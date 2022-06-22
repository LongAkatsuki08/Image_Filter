clc;
clear;

Image=imread('3.jpg');
Image=rgb2gray(Image);
[m,n]=size(Image);

Gx=[1 0;0 -1];
Gy=[0 1;-1 0];

X=Gx.*m;
Y=Gy.*n;