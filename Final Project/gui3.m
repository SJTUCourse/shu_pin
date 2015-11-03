function varargout = gui3(varargin)
%by ShuPin 2015/11/3
% GUI3 MATLAB code for gui3.fig
%      GUI3, by itself, creates a new GUI3 or raises the existing
%      singleton*.
%
%      H = GUI3 returns the handle to a new GUI3 or the handle to
%      the existing singleton*.
%
%      GUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI3.M with the given input arguments.
%
%      GUI3('Property','Value',...) creates a new GUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui3

% Last Modified by GUIDE v2.5 29-Oct-2015 17:19:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui3_OpeningFcn, ...
                   'gui_OutputFcn',  @gui3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui3 is made visible.
function gui3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui3 (see VARARGIN)

% Choose default command line output for gui3
handles.output = hObject;
set(handles.checkbox3, 'Enable', 'on');
set(handles.checkbox4, 'Enable', 'on');
set(handles.Start_pushbutton, 'Enable', 'off');
set(handles.Stop_pushbutton, 'Enable', 'off');
set(handles.Pause_pushbutton, 'Enable', 'off');
set(handles.fruquency, 'Enable', 'off');
set(handles.edit3, 'Enable', 'off');
set(handles.certain_time, 'Enable', 'off');
set(handles.Continuous, 'Enable', 'off');
set(handles.certain_time, 'Enable', 'off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start_pushbutton.
function Start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StaticDO;

% --- Executes on button press in Stop_pushbutton.
function Stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
instantDoCtrl=getappdata(0,'Ctrl4');
t=getappdata(0,'t4');
if isvalid(t)
   stop(t);
   delete(t);
end
instantDoCtrl.Dispose();


function fruquency_Callback(hObject, eventdata, handles)
% hObject    handle to fruquency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fruquency as text
%        str2double(get(hObject,'String')) returns contents of fruquency as a double
fs=get(handles.fruquency,'String');
setappdata(0,'fs4',str2num(fs));
if str2num(fs)>0
   if str2num(fs)<=50
        setappdata(0,'fs4',str2num(fs))
        set(handles.warning,'string','');
set(handles.Start_pushbutton, 'Enable', 'on');
set(handles.Pause_pushbutton, 'Enable', 'on');
set(handles.Stop_pushbutton, 'Enable', 'on');
    else
        set(handles.warning,'string','<50hz');
   end
else
    set(handles.warning,'string','Please input a positive number');
end


% --- Executes during object creation, after setting all properties.
function fruquency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fruquency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Continuous.
function Continuous_Callback(hObject, eventdata, handles)
% hObject    handle to Continuous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Continuous
if get(handles.Continuous,'Value')==1
    set(handles.certain_time, 'Enable', 'off');
    set(handles.edit3, 'Enable', 'off');
    setappdata(0,'limit4',inf);
else
    set(handles.certain_time, 'Enable', 'on');
    set(handles.edit3, 'Enable', 'on');
end

% --- Executes on button press in certain_time.
function certain_time_Callback(hObject, eventdata, handles)
% hObject    handle to certain_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of certain_time
if get(handles.certain_time,'Value')==1
    set(handles.Continuous, 'Enable', 'off');
else
    set(handles.Continuous, 'Enable', 'on');
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
lt=str2double(get(handles.edit3,'String'));
s=getappdata(0,'fs4');
setappdata(0,'limit4',2*lt*s);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Pause_pushbutton.
function Pause_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Pause_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
text = get(hObject, 'String');
% If the simulation were running:
t=getappdata(0,'t4');
if strcmp(text, 'Pause') == 1
    set(hObject, 'String', 'Countinue');
    % pause it:
    stop(t);
else
    % otherwise, "resume" it:
    set(hObject, 'String', 'Pause');
    start(t);
end;
setappdata(0,'t4',t);
return;

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
if get(handles.checkbox3,'Value')==1
    set(handles.checkbox4, 'Enable', 'off');
    StaticDI
else
    set(handles.checkbox4, 'Enable', 'on');
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox4
if get(handles.checkbox4,'Value')==1
    set(handles.checkbox3, 'Enable', 'off');
    set(handles.fruquency, 'Enable', 'on');
    set(handles.edit3, 'Enable', 'on');
    set(handles.certain_time, 'Enable', 'on');
    set(handles.Continuous, 'Enable', 'on');
    set(handles.certain_time, 'Enable', 'on');
else
    set(handles.checkbox3, 'Enable', 'on');
    set(handles.fruquency, 'Enable', 'off');
    set(handles.edit3, 'Enable', 'off');
    set(handles.certain_time, 'Enable', 'off');
    set(handles.Continuous, 'Enable', 'off');
    set(handles.certain_time, 'Enable', 'off');
end


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
if get(handles.checkbox5,'Value')==1
    set(handles.checkbox6, 'Enable', 'off');
    set(handles.edit4, 'Enable', 'off');
    setappdata(0,'limit4',inf);
else
    set(handles.checkbox6, 'Enable', 'on');
    set(handles.edit4, 'Enable', 'on');
end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
if get(handles.checkbox6,'Value')==1
    set(handles.checkbox5, 'Enable', 'off');
else
    set(handles.checkbox5, 'Enable', 'on');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
lt=str2double(get(handles.edit4,'String'));
s=getappdata(0,'fs4');
setappdata(0,'limit4',2*lt*s);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
instantDoCtrl=getappdata(0,'Ctrl4');
t=getappdata(0,'t4');
if isvalid(t)
   stop(t);
   delete(t);
end
instantDoCtrl.Dispose();