clc
clear
close all

load('stereoParams_cali.mat');

for k = 1:55
    filename_Left = sprintf('D:/Dev_sets/The_ninth/Raw_datasets/31/left_%d.jpg',k);
    filename_Right = sprintf('D:/Dev_sets/The_ninth/Raw_datasets/31/right_%d.jpg',k);
    frameLeft = imread(filename_Left);
    frameRight = imread(filename_Right);
    %figure,imshow(frameLeft);
    %figure,imshow(frameRight);

    %Retification
    [frameLeftRect, frameRightRect] = ...
        rectifyStereoImages(frameLeft, frameRight, stereoParams);
    %figure,imshow(frameLeft,[]);

    %Compute Disparity
    disparityMap = disparity(frameLeftRect, frameRightRect);
    %figure,imshow(disparityMap, [0, 64]);

    %Reconstruct the 3-D Scene
    points3D = reconstructScene(disparityMap, stereoParams);
 
    %Zero setting(set NAH/INF pixel values to zero)
    in = isnan(points3D);
    ii = isinf(points3D);
    points3D(in)=0;
    points3D(ii)=0;
    
    %Normalization
    Slice1 = points3D(:, :, 1);
    Slice2 = points3D(:, :, 2);
    Slice3 = points3D(:, :, 3);
    
    miu1 = mean(Slice1(Slice1~=0));
    s = std(Slice1(Slice1~=0));
    Slice1(Slice1~=0) = (Slice1(Slice1~=0)-miu1)./s;
    
    miu2 = mean(Slice2(Slice2~=0));
    s2 = std(Slice2(Slice2~=0));
    Slice2(Slice2~=0) = (Slice2(Slice2~=0)-miu2)./s2;
    
    miu3 = mean(Slice3(Slice3~=0));
    s3 = std(Slice3(Slice3~=0));
    Slice3(Slice3~=0) = (Slice3(Slice3~=0)-miu3)./s3;
    
    %Concatenation
    map_3d = cat(3, Slice1, Slice2, Slice3);
    
    %ROI
    [row, column, ~] = size(map_3d);
    map_3d = map_3d(floor(row/15):(end-floor(row/4)), floor(column/10):(end-floor(column/5)), :);
    %imshow(map_3d,[]);
    
    %Resize image
    map_3d = imresize(map_3d, [224 224]);
    
    %Save as images
    filename = sprintf('image_%d.jpg',k);
    imwrite(map_3d, filename);
    
    
end