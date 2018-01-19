function saveFeatureMaps(conv_data, layerNo)
    for i = 1:size(conv_data, 3)
        featureMap = conv_data(:, :, i);
        imwrite(featureMap, sprintf('res/featureMaps/layer%d/%d.png', layerNo, i));
    end
end