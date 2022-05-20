clear;
clc;

%% Program to demonstrate the butterworth high pass filtering
imdata =imread('0.jpg');
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

subplot(221);
imshow(imdata);
title('Origin Image');
subplot(222);
imshow(H);
title('2D view of H');
subplot(223);
surf(H);
title('3D view of H');
subplot(224)
imshow(uint8(C));
title('Filtered Image');