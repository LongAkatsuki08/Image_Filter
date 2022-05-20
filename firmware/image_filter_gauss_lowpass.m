clear;
clc;
%% Program to demonstrate the guasse low pass filter
%Read the imput
imdata =imread('Lenna_(test_image).png');
imdata1=rgb2gray(imdata);
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
subplot(221);
imshow(imdata);
title('Origin Image');
subplot(222);
imshow(H);
title('2D view of H');
subplot(223);
%surf(H);
surf(H)
title('3D view of H');
subplot(224)
imshow(uint8(C));
title('Filtered Image');
