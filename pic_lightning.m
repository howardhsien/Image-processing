pic = imread('profile_1.jpg');
pic_d = im2double(pic);
n = 1;
avg_r = mean2(pic_d(:,:,1));
avg_g = mean2(pic_d(:,:,2));
avg_b = mean2(pic_d(:,:,3));

sigma_r = std2(pic_d(:,:,1));
sigma_g = std2(pic_d(:,:,2));
sigma_b = std2(pic_d(:,:,3));
%color median filter
% pic_d(:,:,1) = medfilt2(pic_d(:,:,1));
% pic_d(:,:,2) = medfilt2(pic_d(:,:,2));
% pic_d(:,:,3) = medfilt2(pic_d(:,:,3));

pic_d = imsharpen(pic_d,'Radius',1.5,'amount',3,'threshold',0.7);
pic_d = imadjust(pic_d,[avg_r - n*sigma_r,avg_g - n*sigma_g,avg_b - n*sigma_b;
        avg_r+1.5*n*sigma_r,avg_g+1.5*n*sigma_g,avg_b+1.5*n*sigma_b],[],0.5);
%pic_d = pic_d > 0.95 ?.*0.5;
%pic_d(pic_d >0.8) = pic_d(pic_d > 0.8) .* 0.9;
%pic_hsv = rgb2hsv(pic_d);
%pic_hsv(:,:,3) = histeq(pic_hsv(:,:,3));
%pic_d = hsv2rgb(pic_hsv);
% pic_d(:,:,1) = histeq(pic_d(:,:,1));
% pic_d(:,:,2) = histeq(pic_d(:,:,2));
% pic_d(:,:,3) = histeq(pic_d(:,:,3));


figure;

imshow(pic_d);
title('sharpen(Radius:1.5,amount:3,threshold:0.7) before stretching');
% figure;
% h = histogram(pic_d);
