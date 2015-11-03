% StaticDI.m
%by ShuPin 2015/11/3
% Example Category:
%    DIO
% Matlab(2010 or 2010 above)
%
% Description:
%    This example demonstrates how to use Static DI function.
%
% Instructions for Running:
%    1. Set the 'deviceDescription' for opening the device. 
%    2. Set the 'startPort' as the first port for Di scanning.
%    3. Set the 'portCount' to decide how many sequential ports to 
%       operate Di scanning.
%
% I/O Connections Overview:
%    Please refer to your hardware reference manual.

function StaticDI()

% Make Automation.BDaq assembly visible to MATLAB.
BDaq = NET.addAssembly('Automation.BDaq');

% Configure the following three parameters before running the demo.
% The default device of project is demo device, users can choose other 
% devices according to their needs. 
deviceDescription = 'USB-4704,BID#0';
startPort = int32(0);
portCount = int32(1);
errorCode = Automation.BDaq.ErrorCode.Success;

% Step 1: Create a 'InstantDiCtrl' for DI function.
instantDiCtrl = Automation.BDaq.InstantDiCtrl();
setappdata(0,'Ctrl3',instantDiCtrl);
try
    % Step 2: Select a device by device number or device description and 
    % specify the access mode. In this example we use 
    % AccessWriteWithReset(default) mode so that we can fully control the 
    % device, including configuring, sampling, etc.
    instantDiCtrl.SelectedDevice = Automation.BDaq.DeviceInformation(...
        deviceDescription);
    global s;
    s=[];
    % Step 3: read DI ports' status and show.
    buffer = NET.createArray('System.Byte', int32(64));
    t = timer('TimerFcn', {@TimerCallback, instantDiCtrl, startPort, ...
        portCount, buffer}, 'period', 1, 'executionmode', 'fixedrate'); 
    start(t);
    setappdata(0,'t3',t);
    
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
%instantDiCtrl.Dispose();

end

function result = BioFailed(errorCode)

result =  errorCode < Automation.BDaq.ErrorCode.Success && ...
    errorCode >= Automation.BDaq.ErrorCode.ErrorHandleNotValid;

end

function TimerCallback(obj, event, instantDiCtrl, startPort, ...
    portCount, buffer)
errorCode = instantDiCtrl.Read(startPort, portCount, buffer); 
global s;
if BioFailed(errorCode)
    throw Exception();
end
t=getappdata(0,'t3');
instantDiCtrl=getappdata(0,'Ctrl3');
a=buffer.Get(0);
b=dec2bin(a,8); %1 is the highest bit
s=[s,str2num(b(7))];
if max(s)==1 && min(s)==0
    fz=bin2dec(b(1:6));
    if fz>50
        fz=50;
    end
    setappdata(0,'fs4',fz);
    if str2num(b(8))
        setappdata(0,'t3',t);
        setappdata(0,'Ctrl3',instantDiCtrl);
        StaticDO;
        if isvalid(t)
            stop(t);
            delete(t);
            instantDiCtrl.Dispose();
        end
    end
end
end

