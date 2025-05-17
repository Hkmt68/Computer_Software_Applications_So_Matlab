function varargout = ECG_GUI_SO_BASIC(varargin)
% ECG_GUI_SO_BASIC MATLAB code for ECG_GUI_SO_BASIC.fig
%      ECG_GUI_SO_BASIC, by itself, creates a new ECG_GUI_SO_BASIC or raises the existing
%      singleton*.
%
%      H = ECG_GUI_SO_BASIC returns the handle to a new ECG_GUI_SO_BASIC or the handle to
%      the existing singleton*.
%
%      ECG_GUI_SO_BASIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECG_GUI_SO_BASIC.M with the given input arguments.
%
%      ECG_GUI_SO_BASIC('Property','Value',...) creates a new ECG_GUI_SO_BASIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECG_GUI_SO_BASIC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECG_GUI_SO_BASIC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECG_GUI_SO_BASIC

% Last Modified by GUIDE v2.5 18-May-2024 15:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECG_GUI_SO_BASIC_OpeningFcn, ...
                   'gui_OutputFcn',  @ECG_GUI_SO_BASIC_OutputFcn, ...
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


% --- Executes just before ECG_GUI_SO_BASIC is made visible.
function ECG_GUI_SO_BASIC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECG_GUI_SO_BASIC (see VARARGIN)

% Choose default command line output for ECG_GUI_SO_BASIC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECG_GUI_SO_BASIC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECG_GUI_SO_BASIC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Seri port ayarları
serialPort = 'COM7'; % Arduino'nun bağlı olduğu seri portu belirtin
baudRate = 9600;
s = serialport(serialPort, baudRate);

% Veri okuma ve grafik oluşturma
data = [];
axes(handles.axis1); % Çizimi axis1'e yerleştirin
h = plot(nan, nan); % Boş bir grafik oluşturma
xlabel('Zaman (ms)');
ylabel('EKG Sinyali');
title('Gerçek Zamanlı EKG Grafiği');

while ishandle(h) % Grafik penceresi açık olduğu sürece döngü devam eder
    if s.NumBytesAvailable > 0
        % Seri porttan veri oku
        newData = readline(s); % Bu satırı değiştirdik
        data = [data; str2double(newData)];
        
        % Zaman ölçeğini güncelle
        time = (0:length(data)-1) * 2; % 2 ms örnekleme periyodu
    
        % Grafiği güncelle
        set(h, 'XData', time, 'YData', data);
        drawnow;
    end
end

% Seri portu kapatma ve temizleme
clear s; % Seri port nesnesini sil
