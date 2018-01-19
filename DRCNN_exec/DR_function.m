function [im_h, im_gnd] = DR_function(im_input, im_gnd, isRefine)

if nargin < 3
    isRefine = 0;    
end

if isRefine == 0
%% set parameters
% up_scale = 3;
% model = 'model/9-5-5(ImageNet)/x3.mat';
% up_scale = 3;
% model = 'model/9-3-5(ImageNet)/x3.mat';
up_scale = 3;
model = 'model/9-1-5(75 images)/x3_rgb3.mat';
% up_scale = 3;
% model = 'model/9-1-5(ImageNet)/x3.mat';
% up_scale = 2;
% model = 'model/9-5-5(ImageNet)/x2.mat'; 
% up_scale = 4;
% model = 'model/9-5-5(ImageNet)/x4.mat';
else
    up_scale = 3;
    model = 'model/refineNet/refineNet.mat';
end

im_gnd = modcrop(im_gnd, up_scale);
im_gnd = single(im_gnd)/255;

im_input = modcrop(im_input, up_scale);
im_input = single(im_input)/255;

if isRefine == 0
    %% DRCNN
    im_h = DRCNN(model, im_input);
else
    %% refineCNN
    im_h = refineCNN(model, im_input);
end

%% remove border
im_h = shave(uint8(im_h * 255), [up_scale, up_scale]);
im_gnd = shave(uint8(im_gnd * 255), [up_scale, up_scale]);
im_input = shave(uint8(im_input * 255), [up_scale, up_scale]);

end
