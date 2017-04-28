I = imread('Lighthouse.jpg');
figure;
imshow(I)

%I am using a colored image

I = im2double(I);
I = log(1 + I);
M = 2*size(I,1) + 1;
N = 2*size(I,2) + 1;
sigma = 10;
[X, Y] = meshgrid(1:N,1:M);
centerX = ceil(N/2);
centerY = ceil(M/2);
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H = 1 - H;

imshow(H,'InitialMagnification',25)

H = fftshift(H);
If = fft2(I, M, N);
Iout = real(ifft2(repmat( H, [1, 1, 3 ] ) .* If));
Iout = Iout(1:size(I,1),1:size(I,2),:);



Ihmf = exp(Iout) - 1;



avg_r = mean2(Ihmf(:,:,1));
avg_g = mean2(Ihmf(:,:,2));
avg_b = mean2(Ihmf(:,:,3));

sigma_r = std2(Ihmf(:,:,1));
sigma_g = std2(Ihmf(:,:,2));
sigma_b = std2(Ihmf(:,:,3));
%color median filter
% Ihmf(:,:,1) = medfilt2(Ihmf(:,:,1));
% Ihmf(:,:,2) = medfilt2(Ihmf(:,:,2));
% Ihmf(:,:,3) = medfilt2(Ihmf(:,:,3));

n= 0.1
Ihmf = imadjust(Ihmf,[avg_r - n*sigma_r,avg_g - n*sigma_g,avg_b - n*sigma_b;
      avg_r+1.5*n*sigma_r,avg_g+1.5*n*sigma_g,avg_b+1.5*n*sigma_b],[],0.5);

I_blend = (Ihmf + I*5)/6;






subplot(1,3,1);
imshow(I);

subplot(1,3,2);
imshow(Ihmf);

subplot(1,3,3);
imshow(I_blend);
% imshowpair(I, Ihmf, 'montage');