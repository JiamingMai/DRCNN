for i = 1:14
    im1 = imread(['D:\Papers\我的论文\ICIP 2017\res\ours\' num2str(i) '.png']);
    im2 = imread(['D:\Papers\我的论文\ICIP 2017\res\ground_true\' num2str(i) '.png']);
    im2 = imresize(im2, [size(im1, 1) size(im1, 2)]);
    im1 = double(im1)/255;
    im2 = double(im2)/255;
    im1_r = im1(:,:,1);
    im1_g = im1(:,:,2);
    im1_b = im1(:,:,3);
    im2_r = im2(:,:,1);
    im2_g = im2(:,:,1);
    im2_b = im2(:,:,1);
    vif = vifvec(im2_r, im1_r)
    [qi_r, qi_r_map] = img_qi(im1_r, im2_r);
    [qi_g, qi_r_map] = img_qi(im1_g, im2_g);
    [qi_b, qi_r_map] = img_qi(im1_b, im2_b);
    qi = (qi_r + qi_g + qi_b) / 3
    
    im1
end