%% Identifying a Traffic Sign with Features
% use features to count the number of corners on a sign

%% Detect yield sign with features in image
load yield
frameHSV = rgb2hsv(yield);
bm = thresholdImage(frameHSV);
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('disk',10));
figure; 
imshow(bm); 
title('Binary Mask');
