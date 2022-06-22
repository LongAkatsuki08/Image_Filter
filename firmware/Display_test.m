function varargout = Display_test(varargin)
% DISPLAY_TEST MATLAB code for Display_test.fig
%      DISPLAY_TEST, by itself, creates a new DISPLAY_TEST or raises the existing
%      singleton*.
%
%      H = DISPLAY_TEST returns the handle to a new DISPLAY_TEST or the handle to
%      the existing singleton*.
%
%      DISPLAY_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAY_TEST.M with the given input arguments.
%
%      DISPLAY_TEST('Property','Value',...) creates a new DISPLAY_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Display_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Display_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Display_test

% Last Modified by GUIDE v2.5 11-Jun-2022 11:32:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Display_test_OpeningFcn, ...
                   'gui_OutputFcn',  @Display_test_OutputFcn, ...
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


% --- Executes just before Display_test is made visible.
function Display_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Display_test (see VARARGIN)

% Choose default command line output for Display_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Display_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Display_test_OutputFcn(hObject, eventdata, handles) 
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

[name,path] = uigetfile({'*.*';'*.jpg';'*.png'},'Choose pic to open');
Image = [path name];
Image = imread(Image);
axes(handles.Origin);
imshow(Image);
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
val=get(handles.listbox1,'Value');
switch(val)
    case 2
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider1,'Value');

%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel

H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;
        H(i,j) = exp(-d/2/data/data);
    end
end
H=H-1;

%Input image in frequecy domain

A_f = fftshift(fft2(imdata));

%Apply Gaussian HPF

B = A_f.*H;     
C = abs(ifft2(B));
    case 3 
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider1,'Value');
%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel
H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;
        H(i,j) = exp(-d/2/data/data);
    end
end

%Input image in frequecy domain

A_f = fftshift(fft2(imdata));

%Apply the Gaussian low pass filter 

B = A_f.*H;
C = abs(ifft2(B));
    case 5
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequencydata=get(handles.slider4,'Value');
data=get(handles.slider1,'Value');
%Set the filter order
N=10;

%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel

H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;     
        H(i,j) = 1/(1+((d/data/data).^(2*N)));
    end
end


%Input image in frequecy domain

A_f = fftshift(fft2(imdata));

%Apply Butterworth LPF

B = A_f.*H;
C = abs(ifft2(B));
    case 4
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider1,'Value');

%Set the filter order
N=1;

%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel

H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;
        if d~=0
        H(i,j) = 1/(1+((data*data/d).^(2*N)));
        end
    end
end


%Input image in frequecy domain

A_f = fftshift(fft2(imdata));

%Apply Butterworth HPF

B = A_f.*H;
C = abs(ifft2(B));
        
end
set(handles.Filtered);
axes(handles.Filtered);
imshow(uint8(C));
title('GHP Image');
    

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data=get(handles.slider1,'Value');
data1=num2str(data);
set(handles.edit1,'String',data1);

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
