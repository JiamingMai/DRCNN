clear; clc; close all;
modelPath = 'model/9-1-5(91 images)/x3_rgb2.mat';
load(modelPath);
[channelsNum, filterSize, mapsNum] = size(weights_conv1);
minVal = min(weights_conv1(:));
weights_conv1 = weights_conv1 - minVal;
maxVal = max(weights_conv1(:));
weights_conv1 = weights_conv1 ./ maxVal;
for i = 1:mapsNum
    filter_ = weights_conv1(:,:,i)';
    filter_ = reshape(filter_, [sqrt(filterSize), sqrt(filterSize), channelsNum]);
    %imshow(filter_);
    imwrite(filter_, sprintf('res/visualization/conv1_%d.png', i));
end