% Copyright 2014-2015 The MathWorks, Inc.
%% Feature matching
matchFrames
close all
clc

%% Estimate the geometric transform between 'fixed' and 'moving' frames
% Load random number generator state to reproduce same results 
% (for demonstration purposes)
load randomInitializer.mat
rng(randomState)

% Estimate transform
[tform,inlierPoints2,inlierPoints1] = ...
  estimateGeometricTransform(matchedPoints2,matchedPoints1,...
  'projective');

% Reset random number generator state
rng('default')

%% Visualize the features that are used for the estimation
figure 
showMatchedFeatures(vidFrame1,vidFrame2,...
    inlierPoints1,inlierPoints2,'montage')
title('Points used for Estimating Transform')

%% Transform moving image
moving1 = imwarp(vidFrame2,tform);

%% Visualize images
figure 
subplot(2,2,1)
imshow(vidFrame1)
title('Fixed Image')
subplot(2,2,2)
imshow(vidFrame2)
title('Moving Image')
subplot(2,2,3)
imshow(moving1)
title('Transformed (Moving) Image')
subplot(2,2,4)
imshowpair(vidFrame1,moving1,'blend')
title('Transformed and Fixed Images Overlaid')

%% Transform moving image with fixed image reference
% Create a spatial referencing object such that the output image is
% same size as the fixed image
rFixed = imref2d(size(grayFrame1));

% Transform 'moving' image
moving2 = imwarp(vidFrame2,tform,...
'OutputView',rFixed);

%% Visualize images
figure 
subplot(2,2,1)
imshow(vidFrame1)
title('Fixed Image')
subplot(2,2,2)
imshow(vidFrame2)
title('Moving Image')
subplot(2,2,3)
imshow(moving2)
title('Transformed (Moving) Image')
subplot(2,2,4)
imshowpair(vidFrame1,moving2,'blend')
title('Transformed and Fixed Images Overlaid')