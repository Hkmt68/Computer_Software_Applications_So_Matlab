function varargout = ECG_2(varargin)
% ECG_2 MATLAB code for ECG_2.fig
%      ECG_2, by itself, creates a new ECG_2 or raises the existing
%      singleton*.
%
%      H = ECG_2 returns the handle to a new ECG_2 or the handle to
%      the existing singleton*.
%
%      ECG_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECG_2.M with the given input arguments.
%
%      ECG_2('Property','Value',...) creates a new ECG_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECG_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECG_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECG_2

% Last Modified by GUIDE v2.5 18-May-2024 17:47:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECG_2_OpeningFcn, ...
                   'gui_OutputFcn',  @ECG_2_OutputFcn, ...
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


% --- Executes just before ECG_2 is made visible.
function ECG_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECG_2 (see VARARGIN)

handles.serialPort = [];
% Choose default command line output for ECG_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECG_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECG_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
    global stopPlotting;
    stopPlotting = false;

    % Setup the serial port if it's not already open
    if isempty(handles.serialPort) || ~isvalid(handles.serialPort)
        handles.serialPort = serialport('COM7', 9600);
    end

    % Prepare the axis and initialize the plot
    axes(handles.axes1);
    handles.h = plot(nan, nan);  % Initialize the plot handle
    xlabel('Time (ms)');
    ylabel('ECG Signal');
    title('Real-time ECG Graph');
    guidata(hObject, handles);  % Update the handles structure

    % Read data from the serial port and update the plot
    while ishandle(handles.h) && ~stopPlotting
        data = read(handles.serialPort, 1, "uint16");  % Read one uint16 data
        if ~isempty(data)
            newData = double(data);  % Convert to double for plotting
            existingData = get(handles.h, 'YData');
            newData = [existingData, newData];  % Append new data
            set(handles.h, 'YData', newData);
            set(handles.h, 'XData', 0:length(newData)-1);  % Update x data
            drawnow;
        end
    end


function pushbutton2_Callback(hObject, eventdata, handles)
    global stopPlotting;
    stopPlotting = true;  % Set the flag to stop the plotting loop

    % Clean up the serial port
    if ~isempty(handles.serialPort) && isvalid(handles.serialPort)
        configureTermination(handles.serialPort);
        handles.serialPort = [];  % Clear the serial port from handles
        guidata(hObject, handles);  % Update handles structure
    end


function configureTermination(serialPort)
    % Additional cleanup for the serial port
    flush(serialPort);  % Clear the input and output buffers
    clear serialPort;   % Remove the serial port object

