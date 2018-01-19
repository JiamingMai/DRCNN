function im_h = refineCNN(model, im_b)

%% load CNN model parameters
load(model);
[conv1_channels,conv1_patchsize2,conv1_filters] = size(weights_conv1);
conv1_patchsize = sqrt(conv1_patchsize2);
[hei, wid, channels] = size(im_b);

%% conv1
conv1_data = zeros(hei, wid, conv1_filters);
for i = 1 : conv1_filters
    for j = 1 : conv1_channels
        conv1_subfilter = reshape(weights_conv1(j,:,i), conv1_patchsize, conv1_patchsize);
        conv1_data(:,:,i) = conv1_data(:,:,i) + imfilter(im_b(:,:,j), conv1_subfilter, 'same', 'replicate');
    end
    conv1_data(:,:,i) = max(conv1_data(:,:,i) + biases_conv1(i), 0);
end

%% DRCNN reconstruction
im_h = zeros(hei, wid, 3);
for i = 1 : 3
    im_h(:, :, i) = conv1_data(:,:, i) + biases_conv1(i);
end