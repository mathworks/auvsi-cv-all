% Copyright 2014-2015 The MathWorks, Inc
%% Select XML file for detection
addpath('XML Files')
detector = vision.CascadeObjectDetector('bikedetector_9_25.xml');

%% Load input
load InputTM4

%% Find the bounding box
bbox = step(detector,I);

%% Mark the location on the image using a bounding box
J = insertShape(I,'rectangle',bbox);
imshow(J)

%% Clean up
release(detector)