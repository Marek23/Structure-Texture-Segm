clear; close all;

%images = dir('C:\MAREK\MAGISTERKA\Obrazy\imgmask\*.bmp');

%for image=1:length(images)

%clearvars -except image images

I = im2double(imread('test.png'));
lambda = 0.001;

%% konwertujê RGB na Spherical Coordinate System zgodnie z artyku³em "Image Inpainting via Fluid Equation, 2006
L = rgb2lab(I);
R = L(:,:,1);
T = L(:,:,2);
F = L(:,:,3);

%% dla R T i F robiê rozbicie tesktury i struktury
tic
[RUN1,RV] = StructureTexture(R,lambda);
[TUN1,TV] = StructureTexture(T,lambda);
[FUN1,FV] = StructureTexture(F,lambda);
ts = toc;

U(:,:,1) = RUN1;
U(:,:,2) = TUN1;
U(:,:,3) = FUN1;
V(:,:,1) = RV;
V(:,:,2) = TV;
V(:,:,3) = FV;
V = V* 10; %TODO usun?? w przypadku wmalowywania, dodane dla uwidocznienia

imwrite(lab2rgb(U), ['test_u' 'lambda_' num2str(lambda) 'ts_' num2str(ts) '.png']);
figure
imshow(lab2rgb(U))
imwrite(lab2rgb(V), ['test_v' 'lambda_' num2str(lambda) 'ts_' num2str(ts) '.png']);
figure
imshow(lab2rgb(V))
