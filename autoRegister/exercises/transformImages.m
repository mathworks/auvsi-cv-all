%% Transform Images
% Create a 2-D geometric transform object with the affine2d method, to rotate and transform an image

% Copyright 2014-2015 The MathWorks, Inc.

% Load image
load yield

% Create custom rotation transformation
theta = 45; % Rotation in degrees
A = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]; % rotation matrix
tformR = affine2d(A); % Transform object
rotWarp = imwarp(yield,tformR);
figure('Position',[100  624.2000  498.4000  256.0000]);
imshow(rotWarp); 
title('custom rotation warp')

% Create custom translation transformation
tx = 40; % x translation
ty = 80; % y translation
A = [1 0 0; 0 1 0; tx ty 1]; % Translation matrix
tformT = affine2d(A); % Transform object
[xLimit, yLimit] = outputLimits(tformT,[1 size(yield,2)], [1 size(yield,1)]);
outputView = imref2d([yLimit(2) xLimit(2)],[1 xLimit(2)],[1 yLimit(2)]);
transWarp = imwarp(yield,tformT,'OutputView',outputView); 
figure('Position',[100  50.2000  498.4000  256.0000]);
imshow(transWarp); 
title('custom translation warp')




