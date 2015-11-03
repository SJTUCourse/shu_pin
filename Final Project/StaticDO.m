% StaticDO.m
%by ShuPin 2015/11/3
% Example Category:
%    DIO
% Matlab(2010 or 2010 above)
%
% Description:
%    This example demonstrates how to use Static DO function.
%
% Instructions for Running:
%    1. Set the 'deviceDescription' for opening the device. 
%    2. Set the 'startPort' as the first port for Do.
%    3. Set the 'portCount' to decide how many sequential ports to 
%       operate Do.
%
% I/O Connections Overview:
%    Please refer to your hardware reference manual.

function StaticDO()

% Make Automation.BDaq assembly visible to MATLAB.
BDaq = NET.addAssembly('Automation.BDaq');

% Configure the following three parameters before running the demo.
% The default device of project is demo device, users can choose other 
% devices according to their needs. 
deviceDescription = 'USB-4704,BID#0'; 
startPort = int32(0);
portCount = int32(1);

errorCode = Automation.BDaq.ErrorCode.Success;

% Step 1: Create a 'InstantDoCtrl' for DO function.
instantDoCtrl = Automation.BDaq.InstantDoCtrl();
setappdata(0,'Ctrl4',instantDoCtrl);
setappdata(0,'number2',0);
try
    % Step 2: Select a device by device number or device description and 
    % specify the access mode. In this example we use 
    % AccessWriteWithReset(default) mode so that we can fully control the 
    % device, including configuring, sampling, etc.
    instantDoCtrl.SelectedDevice = Automation.BDaq.DeviceInformation(...
        deviceDescription);
    
    % Step 3: Write DO ports
    bufferForWriting = NET.createArray('System.Byte', int32(64));
%    for i = 0:(portCount - 1)
%        fprintf('Input a hexadecimal number for DO port %d to output', ...
%            startPort + i);
%        strData = input('(for example, 0x11)\n', 's'); 
%        strData = System.String(strData);
%        if strData.Substring(0, 2) == '0x'
%            strData = strData.Remove(0, 2);
%       end
%        strData = hex2dec(char(strData));      %strData is a decimal now.
%        bufferForWriting.Set(i, strData); 
%    end
    errorCode = instantDoCtrl.Write(startPort, portCount, ...
        bufferForWriting);
    if BioFailed(errorCode)
        throw  Exception();
    end
    fs=getappdata(0,'fs4');
    t = timer('TimerFcn',{@TimerCallback,instantDoCtrl,bufferForWriting}, 'period', 0.5/fs, ...
        'executionmode', 'fixedrate');
    start(t);
    setappdata(0,'t4',t);
    %input('Press Enter key to quit!', 's');    
    %stop(t);
    %delete(t);
    %disp('DO output completed!');
    % Read back the DO status.
    % Note:
    % For relay output, the read back must be deferred until 
    % the relay is stable.
    % The delay time is decided by the HW SPEC.
    %bufferForReading = NET.createArray('System.Byte', int32(64));
    %instantDoCtrl.Read(startPort, portCount, bufferForReading);
    %if BioFailed(errorCode)
    %    throw  Exception();
    %end
    % Show DO ports' status
    %for i = startPort:(portCount + startPort - 1)
    %   fprintf('Now, DO port %d status is:  0x%X\n', i, ...
    %       bufferForReading.Get(i - startPort));
    %end
catch e
    % Something is wrong. 
    if BioFailed(errorCode)    
        errStr = 'Some error occurred. And the last error code is ' ... 
            + errorCode.ToString();
    else
        errStr = e.message;
    end
    disp(errStr);
end   

% Step 4: Close device and release any allocated resource.
%instantDoCtrl.Dispose();

end

function result = BioFailed(errorCode)

result =  errorCode < Automation.BDaq.ErrorCode.Success && ...
    errorCode >= Automation.BDaq.ErrorCode.ErrorHandleNotValid;

end

function TimerCallback(obj, event,instantDoCtrl,bufferForWriting)
instantDoCtrl=getappdata(0,'Ctrl4');
fs=getappdata(0,'fs4');
t=getappdata(0,'t4');
persistent i;
if isempty(i)
    i=0;
else
    i=~i;
end
disp(i);
j=getappdata(0,'number2');
if isempty(j)
    j=0;
else
    j=j+1;
end
lt4=getappdata(0,'limit4');
flag=getappdata(0,'flag');
if j<lt4
    bufferForWriting.Set(0,i);
    errorCode = instantDoCtrl.Write(0,1,bufferForWriting);
    if BioFailed(errorCode)
         throw  Exception();
    end
else
    if isvalid(t)
        stop(t);
        delete(t);
        instantDoCtrl.Dispose();
    end
end
setappdata(0,'number2',j);
setappdata(0,'t4',t);
end