clear; clc;
model = 'model/9-1-5(75 images)/x3_rgb3.mat';
load(model);
weight_size = sqrt(size(weights_conv1, 2));
for i = 1 : size(weights_conv1, 3)
    for j = 1 : 3
        weight = weights_conv1(j, :, i)';
        weight = reshape(weight, [weight_size, weight_size, 1]);
        weight_resized = imresize(weight, [100, 100]);
        weight_colored = colorFilter(weight_resized);
        imwrite(weight_colored, ['res/weights/conv1_' num2str(j) '/' num2str(i) '.png']);
    end    
end
