% Copyright 2014-2015 The MathWorks, Inc
%% Load input and view image
load InputHOG
imshow(I)

%% Extract HOG Features
[hog16, vis16] = extractHOGFeatures(I,'CellSize',[16 16]);

%% Visualize results
hold on
plot(vis16)