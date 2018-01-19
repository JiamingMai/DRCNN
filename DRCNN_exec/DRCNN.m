function im_h = DRCNN(model, im_b)

%% load CNN model parameters
load(model);
[conv1_channels,conv1_patchsize2,conv1_filters] = size(weights_conv1);
conv1_patchsize = sqrt(conv1_patchsize2);
[conv2_channels,conv2_patchsize2,conv2_filters] = size(weights_conv2);
conv2_patchsize = sqrt(conv2_patchsize2);
[conv3_channels,conv3_patchsize2,conv3_filters] = size(weights_conv3);
conv3_patchsize = sqrt(conv3_patchsize2);
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
saveFeatureMaps(conv1_data, 1);

%% conv2
conv2_data = zeros(hei, wid, conv2_filters);
for i = 1 : conv2_filters
    for j = 1 : conv2_channels
        conv2_subfilter = reshape(weights_conv2(j,:,i), conv2_patchsize, conv2_patchsize);
        conv2_data(:,:,i) = conv2_data(:,:,i) + imfilter(conv1_data(:,:,j), conv2_subfilter, 'same', 'replicate');
    end
    conv2_data(:,:,i) = max(conv2_data(:,:,i) + biases_conv2(i), 0);
end
saveFeatureMaps(conv2_data, 2);

%% conv3
conv3_data = zeros(hei, wid, conv3_filters);
for i = 1 : conv3_filters
    for j = 1 : conv3_channels
        conv3_subfilter = reshape(weights_conv3(j,:,i), conv3_patchsize, conv3_patchsize);
        conv3_data(:,:,i) = conv3_data(:,:,i) + imfilter(conv2_data(:,:,j), conv3_subfilter, 'same', 'replicate');
    end
    conv3_data(:,:,i) = max(conv3_data(:,:,i) + biases_conv3(i), 0);
end

%% DRCNN reconstruction
im_h = zeros(hei, wid, channels);
for i = 1 : channels
    im_h(:, :, i) = conv3_data(:,:, i) + biases_conv3(i);
end