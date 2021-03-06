function varargout = Display(varargin)
% DISPLAY MATLAB code for Display.fig
%      DISPLAY, by itself, creates a new DISPLAY or raises the existing
%      singleton*.
%
%      H = DISPLAY returns the handle to a new DISPLAY or the handle to
%      the existing singleton*.
%
%      DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAY.M with the given input arguments.
%
%      DISPLAY('Property','Value',...) creates a new DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Display

% Last Modified by GUIDE v2.5 11-Jun-2022 11:11:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Display_OpeningFcn, ...
                   'gui_OutputFcn',  @Display_OutputFcn, ...
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

% --- Executes just before Display is made visible.
function Display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Display (see VARARGIN)

% Choose default command line output for Display
handles.output = hObject;
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
axes(handles.Origin)
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
axes(handles.Filtered1)
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
axes(handles.Filtered2)
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
axes(handles.Filtered3)
set (gca, 'xtick' , [])
set (gca, 'ytick' , [])
axes(handles.Filtered4)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Display wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[name,path] = uigetfile({'*.*';'*.jpg';'*.png'},'Choose pic to open');
 Image = [path name];
 Image = imread(Image);
axes(handles.Origin);
imshow(Image);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider4,'Value');
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
axes(handles.Filtered1);
imshow(uint8(C));
title('GLP image');
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider4,'Value');

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

%Display the output  and input image

% subplot(221);
% imshow(imdata);
% title('Origin Image');
% subplot(222);
% imshow(H);
% title('2D view of H');
% subplot(223);
% surf(H);
% title('3D view of H');
% subplot(224)
axes(handles.Filtered2);
imshow(uint8(C));
title('GHP Image');
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequencydata=get(handles.slider4,'Value');
data=get(handles.slider4,'Value');
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

%Display the output  and input image
% 
% subplot(221);
% imshow(imdata);
% title('Origin Image');
% subplot(222);
% imshow(H);
% title('2D view of H');
% subplot(223);
% surf(H);
% title('3D view of H');
% subplot(224)
axes(handles.Filtered3);
imshow(uint8(C));
title('IIR LP Image');
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
imdata=getimage(handles.Origin);
[m,n,z]=size(imdata);
if (z==3)
imdata=rgb2gray(imdata);
[m,n,z]=size(imdata);
end
%Set the cut-off frequency
data=get(handles.slider4,'Value');

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

%Display the output  and input image

% subplot(221);
% imshow(imdata);
% title('Origin Image');
% subplot(222);
% imshow(H);
% title('2D view of H');
% subplot(223);
% surf(H);
% title('3D view of H');
% subplot(224)
axes(handles.Filtered4);
imshow(uint8(C));
title('IIR HP Image');
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
data=get(handles.slider3,'Value')
data1=num2str(data)
set(handles.edit3,'String',data1)
% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
data=get(handles.slider4,'Value')
data1=num2str(data)
set(handles.edit3,'String',data1)

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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
