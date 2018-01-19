clear; clc; close all;

fileName = sprintf('img.png');
im_gnd  = imread(['Train/label/' fileName]); % read ground truth image
%im_input = imread(['Train/input/' fileName]);
im_input = imread('Test/realImgs/wuyan.png'); % read input image
im_h = im_input;
im_original_input = im_input;
up_scale = 3;
tic;
epoch = 2;
for i = 1:epoch
    fprintf('Epoch #%d/%d\n', i, epoch);
    [im_h, im_gnd] = DR_function(im_h, im_gnd, 0);    
    im_original_input = modcrop(im_original_input, up_scale);
    im_original_input = single(im_original_input)/255;
    im_original_input = shave(uint8(im_original_input * 255), [up_scale, up_scale]);
end
toc;
im_input = im_original_input;

im_r = (double(im_input)/255 - double(im_h)/255) ./ (1 - double(im_h)/255);
im_r = rgb2gray(im_r);
im_r = uint8(im_r * 255);

%% compute SSIM
%ssim_input = ssim(im_input, im_gnd);
%ssim_drcnn = ssim(im_h, im_gnd);

%% compute PSNR
%psnr_input = compute_psnr(im_gnd, im_input);
%psnr_drcnn = compute_psnr(im_gnd, im_h);

%% show results
%fprintf('PSNR for Input Rainy Image: %f dB, SSIM is %f\n', psnr_input, ssim_input);
%fprintf('PSNR for DRCNN Reconstruction: %f dB, SSIM is %f\n', psnr_drcnn, ssim_drcnn);

figure, imshow(im_h); title('DRCNN Reconstruction');
imwrite(im_h, sprintf('res/%s_raw.png', fileName));

im_refine_input = zeros(size(im_input, 1), size(im_input, 2), 6);
im_refine_input(:, :, 1) = im_input(:, :, 1);
im_refine_input(:, :, 2) = im_input(:, :, 2);
im_refine_input(:, :, 3) = im_input(:, :, 3);
im_refine_input(:, :, 4) = im_h(:, :, 1);
im_refine_input(:, :, 5) = im_h(:, :, 2);
im_refine_input(:, :, 6) = im_h(:, :, 3);

for i = 1:1
    [im_h, im_gnd] = DR_function(im_refine_input, im_gnd, 1);   
    im_original_input = modcrop(im_original_input, up_scale);
    im_original_input = single(im_original_input)/255;
    im_original_input = shave(uint8(im_original_input * 255), [up_scale, up_scale]);
end
im_input = im_original_input;

%% compute SSIM
%ssim_input = ssim(im_input, im_gnd);
%ssim_drcnn = ssim(im_h, im_gnd);

%% compute PSNR
%psnr_input = compute_psnr(im_gnd, im_input);
%psnr_drcnn = compute_psnr(im_gnd, im_h);

%% show results
%fprintf('PSNR for Input Rainy Image: %f dB, SSIM is %f\n', psnr_input, ssim_input);
%fprintf('PSNR for Refined Result: %f dB, SSIM is %f\n', psnr_drcnn, ssim_drcnn);

figure, imshow(im_gnd); title('Ground Truth Image');
figure, imshow(im_input); title('Input Rainy Image');
figure, imshow(im_r); title('Rain Layer');
figure, imshow(im_h); title('Refined Result');

imwrite(im_h, sprintf('res/%s_refined.png', fileName));
%imwrite(im_h, sprintf('res/%s_DRCNN_epoch_%d.png', fileName, epoch));