function varargout = slider1(varargin)
% SLIDER1 MATLAB code for slider1.fig
%      SLIDER1, by itself, creates a new SLIDER1 or raises the existing
%      singleton*.
%
%      H = SLIDER1 returns the handle to a new SLIDER1 or the handle to
%      the existing singleton*.
%
%      SLIDER1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER1.M with the given input arguments.
%
%      SLIDER1('Property','Value',...) creates a new SLIDER1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slider1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slider1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slider1

% Last Modified by GUIDE v2.5 05-Jun-2022 12:44:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slider1_OpeningFcn, ...
                   'gui_OutputFcn',  @slider1_OutputFcn, ...
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


% --- Executes just before slider1 is made visible.
function slider1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slider1 (see VARARGIN)

% Choose default command line output for slider1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes slider1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slider1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
data=get(handles.slider1,'Value');
data1=num2str(data);
set(handles.edit1,'String',data1)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[name,path] = uigetfile({'*.*';'*.jpg';'*.png'},'Choose pic to open');
 Image = [path name];
 Image = imread(Image);
axes(handles.axes1);
imshow(Image);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imdata=getimage(handles.axes1);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end

data1=get(handles.slider1,'Value');
%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel
H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;
        H(i,j) = exp(-d/2/data1/data1);
    end
end

%Input image in frequecy domain

A_f = fftshift(fft2(imdata));

%Apply the Gaussian low pass filter 

B = A_f.*H;
C = abs(ifft2(B));

%Display the output  and input image
% subplot(221);
% imshow(imdata);
% title('Origin Image');
% subplot(222);
% imshow(H);
% title('2D view of H');
% subplot(223);
% %surf(H);
% surf(H)
% title('3D view of H');
% subplot(224)
axes(handles.axes2);
imshow(uint8(C));
title('GLP image');
