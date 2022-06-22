clc;
clear;
image=imread('1.jpg');
image=rgb2gray(image);
Image=edge(image,'sobel');
figure(1);
imshow(Image);