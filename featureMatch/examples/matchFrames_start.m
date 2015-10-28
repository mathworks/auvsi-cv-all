% Copyright 2014-2015 The MathWorks, Inc.
%% Load two original and grayscale frames to compare
load sampleFrames 
load sampleGrayFrames %Use this for feature detection
figure
subplot(2,2,1)
imshow(vidFrame1) 
title('Original Frame 1')

subplot(2,2,2)
imshow(vidFrame2) 
title('Original Frame 2')

subplot(2,2,3)
imshow(grayFrame1) 
title('Grayscale Frame 1')

subplot(2,2,4)
imshow(grayFrame2) 
title('Grayscale Frame 2')

%% Detect corners using MSER algorithm
mserRegions1 = detectMSERFeatures(grayFrame1);
mserRegions2 = detectMSERFeatures(grayFrame2);

%% Visualize
figure
subplot(1,2,1)
imshow(vidFrame1) 
title('Frame 1')
hold on
plot(mserRegions1)

subplot(1,2,2)
imshow(vidFrame2) 
title('Frame 2')
hold on
plot(mserRegions2)

superTitle('Detected Features');

%% Extract feature descriptors and their corresponding locations


%% Visualize


%% Get the matched features


%% Get points that 'match' by indexing into all points


%% Show matched features
