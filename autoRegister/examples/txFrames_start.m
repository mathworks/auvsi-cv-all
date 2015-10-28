% Copyright 2014-2015 The MathWorks, Inc.
%% Feature matching
matchFrames
close all
clc

%% Estimate the geometric transform between 'fixed' and 'moving' frames


%% Visualize the features that are used for the estimation


%% Transform moving image


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