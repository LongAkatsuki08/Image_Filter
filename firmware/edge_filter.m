clear;
clc;

%% Program to demonstrate the butterworth high pass filtering
%imdata = imread('0.jpg');
imdata = rgb2gray(imread('2.jpg'));
[m,n] = size(imdata);
%data_fft = fft2(imdata,m,n)
%Define the filter kernel
H = [-1 0 1; -2 0 2; -1 0 1]
%H = 1/9*[1 1 1; 1 1 1; 1 1 1]
%Edge filter
%imdata = imnoise(imdata,'gaussian');
Con = conv2(imdata,H);
subplot(211);
imshow(imdata);
subplot(212);
imshow(Con);
