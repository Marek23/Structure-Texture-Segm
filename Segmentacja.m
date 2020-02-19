clear; close all;

images = dir('C:\MAREK\MAGISTERKA\Obrazy\imgmask\*.bmp');

for image=1:length(images)

clearvars -except image images
images(image).name

I = im2double(imread(['C:\MAREK\MAGISTERKA\Obrazy\imgmask\' images(image).name]));
lambda = 1;

%% konwertujê RGB na Spherical Coordinate System zgodnie z artyku³em "Image Inpainting via Fluid Equation, 2006
L = rgb2lab(I);
R = L(:,:,1);
T = L(:,:,2);
F = L(:,:,3);

%% dla R T i F robiê rozbicie tesktury i struktury
tic
[RUN1,RV] = StructureTexture2(R,lambda);
[TUN1,TV] = StructureTexture2(T,lambda);
[FUN1,FV] = StructureTexture2(F,lambda);
ts = toc;

U(:,:,1) = RUN1;
U(:,:,2) = TUN1;
U(:,:,3) = FUN1;
V(:,:,1) = RV;
V(:,:,2) = TV;
V(:,:,3) = FV;
V = V + 0.5;

imwrite(lab2rgb(U), ['C:\MAREK\MAGISTERKA\Latex\Latex\TESTY\SEGMENTACJA\' images(image).name 'U' 'lambda_' num2str(lambda) 'ts_' num2str(ts) '.png']);
imwrite(lab2rgb(V), ['C:\MAREK\MAGISTERKA\Latex\Latex\TESTY\SEGMENTACJA\' images(image).name 'V' 'lambda_' num2str(lambda) 'ts_' num2str(ts) '.png']);

end