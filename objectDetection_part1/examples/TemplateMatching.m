% Copyright 2014-2015 The MathWorks, Inc
%% Load template
load bikeTemplate

%% Load input image and convert to grayscale
load InputTM1
Igray = rgb2gray(I);

%% Setup and perform Template Matching
H = vision.TemplateMatcher;
H.SearchMethod = 'Three-step';
loc = step(H,Igray,T);

%% Visualize results
J = insertMarker(I,loc,'o','Size',10);
imshow(J)