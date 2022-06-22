clc;
clear;
Image=imread('5.jpg');
Image=rgb2gray(Image);
%%Edge Detection
edge_prewitt=edge(Image,'Prewitt');
edge_roberts=edge(Image,'Roberts');
edge_sobel=edge(Image,'Sobel');
figure(1);
imshow(edge_prewitt);
figure(2);
imshow(edge_roberts);
figure(3);
imshow(edge_sobel);
