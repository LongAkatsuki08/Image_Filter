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

% Last Modified by GUIDE v2.5 24-May-2022 20:11:40

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
Image=imread('Zombatar_1.jpg');
axes(handles.Origin);
imshow(Image);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Image1=getimage(handles.Origin);
imdata1=rgb2gray(Image1);
[m,n,z]=size(imdata1);

%Set the cut-off frequency
Fc=90;

%Determine the centre of image
p= round(m/2);
q= round(n/2);
o= round(z/2);

%Define the filter kernel
H=zeros(m,n,z);
for i=1:m
    for j=1:n
        for k=1:o
        d = (i-p).^2+(j-q).^2+(k-o).^2;
        H(i,j,k) = exp(-d/2/Fc/Fc);
        end
    end
end

%Input image in frequecy domain

A_f = fftshift(fft2(imdata1));

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
Image1=getimage(handles.Origin);
imdata1=rgb2gray(Image1);
[m,n]=size(imdata1);
%Set the cut-off frequency
Fc=3;

%Determine the centre of image
p= round(m/2);
q= round(n/2);

%Define the filter kernel

H=zeros(m,n);
for i=1:m
    for j=1:n
        d = (i-p).^2+(j-q).^2;
        H(i,j) = exp(-d/2/Fc/Fc);
    end
end
H=H-1;

%Input image in frequecy domain

A_f = fftshift(fft2(imdata1));

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
Image1=getimage(handles.Origin);
imdata1=rgb2gray(Image1);
[m,n]=size(imdata1);

%Set the cut-off frequency
Fc=100; 

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
        H(i,j) = 1/(1+((d/Fc/Fc).^(2*N)));
    end
end


%Input image in frequecy domain

A_f = fftshift(fft2(imdata1));

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
Image1=getimage(handles.Origin);
imdata=rgb2gray(Image1);
[m,n]=size(imdata);

%Set the cut-off frequency
Fc=20; 

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
        H(i,j) = 1/(1+((Fc*Fc/d).^(2*N)));
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
