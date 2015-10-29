function varargout = mygui(varargin)
% MYGUI MATLAB code for mygui.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mygui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mygui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mygui

% Last Modified by GUIDE v2.5 13-Oct-2015 16:41:09

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mygui_OpeningFcn, ...
                   'gui_OutputFcn',  @mygui_OutputFcn, ...
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



% --- Executes just before mygui is made visible.
function mygui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mygui (see VARARGIN)

% Choose default command line output for mygui
handles.output = hObject;
h=line;
set(h,'Xdata',[],'Ydata',[],'Marker','*');
setappdata(0,'Line',h);
setappdata(0,'hw2',handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mygui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mygui_OutputFcn(hObject, eventdata, handles) 
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
hl=getappdata(0,'Line');
set(hl,'Xdata',[],'Ydata',[]);
trial

function editt_Callback(hObject, eventdata, handles)
% hObject    handle to editt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of editt as text
% str2func(get(hObject,'String')) returns contents of editt as a double
fss=str2double(get(handles.editt,'String'));
setappdata(0,'fss',fss)
h1=handles.Start_pushbutton;
set(h1, 'Enable', 'on');
h2=handles.Pause_pushbutton;
set(h2, 'Enable', 'on');
h3=handles.Exit_pushbutton;
set(h3, 'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function editt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%set(gcbo,'String','5');
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
t=getappdata(0,'t1');
if strcmp(text, 'Pause') == 1
   set(hObject, 'String', 'Countinue');
    % pause it:
  stop(t);
else
    % otherwise, "resume" it:
    set(hObject, 'String', 'Pause');
    start(t);
end;
return;


% --- Executes on button press in Exit_pushbutton.
function Exit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Exit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=getappdata(0,'t1');
stop(t);
delete(t);
st=getappdata(0,'stoptimer');
st.Dispose();


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x1=get(gca,'XLim');
zoom(2);
x2=get(gca,'XLim');
global pro;
p=(x2(2)-x2(1))/(x1(2)-x1(1));
pro=pro*p;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x1=get(gca,'XLim');
zoom(0.5);
x2=get(gca,'XLim');
global pro;
p=(x2(2)-x2(1))/(x1(2)-x1(1));
pro=pro*p;


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ha=getappdata(0,'hw2');
y1=get(ha.axes1,'YLim');
zoom(2);
y2=get(ha.axes1,'YLim');
global proy;
s=(y2(2)-y2(1))/(y1(2)-y1(1));
proy=proy*s;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ha=getappdata(0,'hw2');
y1=get(ha.axes1,'YLim');
zoom(0.5);
y2=get(ha.axes1,'YLim');
global proy;
s=(y2(2)-y2(1))/(y1(2)-y1(1));
proy=proy*s;
