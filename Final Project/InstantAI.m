
% InstantAI.m
%by ShuPin 2015/11/3
% Example Category:
%    AI
% Matlab(2010 or 2010 above)
%
% Description:
%    This example demonstrates how to use Instant AI function.
%
% Instructions for Running:
%    1. Set the 'deviceDescription' for opening the device. 
%    2. Set the 'startChannel' as the first channel for scan analog samples  
%    3. Set the 'channelCount' to decide how many sequential channels to 
%       scan analog samples.
%
% I/O Connections Overview:
%    Please refer to your hardware reference manual.
function InstantAI( )

% Make Automation.BDaq assembly visible to MATLAB.
BDaq = NET.addAssembly('Automation.BDaq');

% Configure the following three parameters before running the demo.
% The default device of project is demo device, users can choose other 
% devices according to their needs. 
deviceDescription = 'USB-4704,BID#0'; 
startChannel = int32(0);
channelCount = int32(1);

% Step 1: Create a 'InstantAiCtrl' for Instant AI function.
instantAiCtrl = Automation.BDaq.InstantAiCtrl();


    % Step 2: Select a device by device number or device description and 
    % specify the access mode. In this example we use 
    % AccessWriteWithReset(default) mode so that we can fully control the 
    % device, including configuring, sampling, etc.
instantAiCtrl.SelectedDevice = Automation.BDaq.DeviceInformation(...
    deviceDescription);
data = NET.createArray('System.Double', channelCount);
setappdata(0,'stoptimer',instantAiCtrl)
    % Step 3: Read samples and do post-process, we show data here.
errorCode = Automation.BDaq.ErrorCode();
global pro;
pro=1;
global proy;
proy=1;
global numb;
numb=0;
fs=getappdata(0,'fs1');
    %t = timer('TimerFcn', {@TimerCallback, instantAiCtrl, startChannel, ...
    %    channelCount, data}, 'period',1/fs, 'executionmode', 'fixedrate', ...
    %    'StartDelay', 1,'StopFcn',{@StopCallback,instantAiCtrl});
t = timer('TimerFcn', {@TimerCallback, instantAiCtrl, startChannel, ...
     channelCount, data}, 'period',1/fs, 'executionmode', 'fixedrate', ...
     'StartDelay', 1);
setappdata(0,'t1',t);
start(t);
    
% Step 4: Close device and release any allocated resource.
%instantAiCtrl.Dispose();

end

function TimerCallback(obj, event, instantAiCtrl, startChannel, ...
    channelCount, data)
errorCode = instantAiCtrl.Read(startChannel, channelCount, data); 
global numb 
numb=numb+1 ;
fs=getappdata(0,'fs1');
x=numb/fs;
y=data.Get(0);
global pro;
global proy;
h=getappdata(0,'Line1');
ha=getappdata(0,'h1');
xdata=get(h,'Xdata');
ydata=get(h,'Ydata');
set(ha.axes1,'XLim',[x-pro,x+pro],'YLim',[-5*proy,5*proy]);
set(ha.axes1,'XTick',(x-pro):0.5:(x+pro));
set(ha.axes1,'XTickLabel',{num2str(x-pro),num2str(x-pro+0.5),num2str(x),num2str(x+pro-0.5),num2str(x+pro)});
set(ha.axes1,'YTick',-5:1:5);
set(ha.axes1,'YTickLabel',{num2str(-5*proy),num2str(-4*proy),num2str(-3*proy),num2str(-2*proy),num2str(-1*proy),num2str(0),num2str(proy),num2str(2*proy),num2str(3*proy),num2str(4*proy),num2str(5*proy)});
set(h,'Xdata',[xdata,x],'Ydata',[ydata,y]);

%set(ha.axes1,'XTick',);
%set(ha.axes1,'Xlim',[x-10*pro,x+10*pro],'Ylim',[-10*proy,10*proy]);
%set(ha.axes1,'XTick',round(x-10*pro):max([round(4*pro),1]):round(x+10*pro));
end