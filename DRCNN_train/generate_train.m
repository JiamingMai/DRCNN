clear;close all;
%% settings
inputFolder = 'Train/input';
labelFolder = 'Train/label';
savepath = 'train.h5';
size_input = 33;
size_label = 21;
scale = 3;
stride = 14;

%% initialization
data = zeros(size_input, size_input, 3, 1);
label = zeros(size_label, size_label, 3, 1);
padding = abs(size_input - size_label)/2;
count = 0;

%% generate data
inputFilepaths = dir(fullfile(inputFolder,'*.png'));
labelFilepaths = dir(fullfile(labelFolder,'*.png'));
    
for i = 1 : length(inputFilepaths)
    
    image = imread(fullfile(inputFolder, inputFilepaths(i).name));    
    image = im2double(image);
    
    labelImage = imread(fullfile(labelFolder, labelFilepaths(i).name));    
    labelImage = im2double(labelImage);
    
    im_input = modcrop(image, scale);
    [hei, wid, channels] = size(im_input);
    % im_input = imresize(imresize(im_label,1/scale,'bicubic'),[hei,wid],'bicubic');
    im_label = modcrop(labelImage, scale);

    for x = 1 : stride : hei-size_input+1
        for y = 1 :stride : wid-size_input+1
            
            subim_input = im_input(x : x+size_input-1, y : y+size_input-1, :);
            subim_label = im_label(x+padding : x+padding+size_label-1, y+padding : y+padding+size_label-1, :);

            count=count+1;
            data(:, :, :, count) = subim_input;
            label(:, :, :, count) = subim_label;
        end
    end
end

order = randperm(count);
data = data(:, :, :, order);
label = label(:, :, :, order); 

%% writing to HDF5
chunksz = 128;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,:,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,:,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
h5disp(savepath);
