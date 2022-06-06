clear;
clc;
imdata =imread('C:\Users\nguye\Desktop\download.jpg')
figure(1);
imshow(imdata);
title('Anh1');

%Lam den anh
imdata=rgb2gray(imdata);
figure(2);
imshow(imdata);
title('Anh den 1');

%Bien doi fourier anh
F=fft(imdata);
S=abs(F);
figure(3);
imshow(S,[]);
title('Bien doi Fourier anh');

%L?y quang ph? t?p trung
Fc=fftshift(F);
s=abs(Fc);
figure(4);
imshow(s,[]);
title('Lay quang pho tap trung anh 1');

%apply log transform
x=log(1+s);
figure (5);
imshow(x,[]);
title('apply log transform anh 1');

%reconstruct image
F=ifftshift(Fc);
f=ifft(F);
figure(6);
imshow(f,[]);
title('Reconstruct image');

%Loc thong cao anh
Hd=Locthongcao
output=filter(Hd,imdata);
figure(7);
imshow(output,[]);
title('Loc thong cao anh');


% %Loc bien,test thu 3 pp loc
% 
% I=imread('C:\Users\nguye\Desktop\download.jpg');
% I2=rgb2gray(I);
% IEr= edge(I2,'roberts');%Bo loc Robert
% IEp= edge(I2,'prewitt');%o loc Prewitt
% IEs= edge(I2,'sobel');%Bo loc Sobel
% 
% figure(8);
% imshow(IEr);
% figure(9);
% imshow(IEp);
% figure(10);
% imshow(IEs);

