% Copyright 2014-2015 The MathWorks, Inc.
%% Load sample frames
load sampleFrames
subplot(1,2,1)
imshow(vidFrame1)
title('Original Frame')

%% Convert to grayscale
grayFrame = rgb2gray(vidFrame1);
subplot(1,2,2)
imshow(grayFrame);
title('Grayscale Frame')

%% Find corners using minimum eigen value
eigCorners = detectMinEigenFeatures(grayFrame);
figure
subplot(1,2,1)
imshow(grayFrame)
hold on
plot(eigCorners)
title('Corners')

%% Find first 100 strongest corners using min eigen value
strongCorners = eigCorners.selectStrongest(100);
subplot(1,2,2)
imshow(grayFrame)
hold on
plot(strongCorners)
title('Strongest 50 Corners')
superTitle('MinEigen Features');

%% Find corners using BRISK
briskCorners = detectBRISKFeatures(grayFrame);
figure
subplot(1,2,1)
imshow(grayFrame)
hold on
plot(briskCorners)
title('NumOctaves:4 (default)')

%% Find BRISK corners with set 'NumOctaves'
briskCornersOct = detectBRISKFeatures(grayFrame,'NumOctaves',1);
subplot(1,2,2)
imshow(grayFrame)
hold on
plot(briskCornersOct)
title('NumOctaves:1')
superTitle('BRISK Features');

%% Find intensity regions using MSER
mserRegions = detectMSERFeatures(grayFrame);
figure
subplot(1,2,1)
imshow(grayFrame)
hold on
plot(mserRegions)
title('ThresholdDelta:2 (default)')

%% Find MSER intensity regions with set 'ThresholdDelta'
mserRegionsTh = detectMSERFeatures(grayFrame,'ThresholdDelta',4);
subplot(1,2,2)
imshow(grayFrame)
hold on
plot(mserRegionsTh)
title('ThresholdDelta:4')
superTitle('MSER Features');