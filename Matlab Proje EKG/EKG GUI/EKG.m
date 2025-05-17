function varargout = EKG(varargin)
% EKG MATLAB code for EKG.fig
%      EKG, by itself, creates a new EKG or raises the existing
%      singleton*.

% --- Initialization code ---
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EKG_OpeningFcn, ...
                   'gui_OutputFcn',  @EKG_OutputFcn, ...
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

% --- Executes just before EKG is made visible.
function EKG_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
serialPorts = serialportlist; % List available serial ports
set(handles.listbox1, 'String', serialPorts); % Populate listbox with serial ports
guidata(hObject, handles); % Update GUI data

function varargout = EKG_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
    handles.data = [];
    handles.stopFlag = false;
    guidata(hObject, handles);

    axes(handles.axes1);
    h = plot(nan, nan);
    xlabel('Time (ms)');
    ylabel('EKG Signal');
    title('Real-Time EKG Graph');

    startTime = tic;
    for k = 1:100 % Test için 100 veri noktası üret
        pause(0.1);
        newData = rand * 100; % Rastgele bir sayı üret
        currentTime = toc(startTime);
        handles.data = [handles.data; [currentTime, newData]];
        set(h, 'XData', handles.data(:,1), 'YData', handles.data(:,2));
        drawnow;
        handles = guidata(hObject);
    end

    handles.stopFlag = true;
    guidata(hObject, handles);




function listbox1_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject, 'String'));
handles.selectedPort = contents{get(hObject, 'Value')};
guidata(hObject, handles);

function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton2_Callback(hObject, eventdata, handles)
handles.stopFlag = true;
guidata(hObject, handles);
