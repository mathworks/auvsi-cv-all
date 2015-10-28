% Copyright 2014-2015 The MathWorks, Inc
%% Select XML file for detection
detector = vision.CascadeObjectDetector('bikedetector_5_50.xml');

%% Load input video
videoReader = vision.VideoFileReader('bikeTorr.mp4');

%% Setup for output video
videoWriter = vision.VideoFileWriter('result_5_50.avi');

%% Detect bike in video
while ~isDone(videoReader)
    I = step(videoReader);
    bbox = step(detector,I);
    J = insertShape(I,'rectangle',bbox);
    step(videoWriter,J);
end

%% Clean up
release(videoReader)
release(videoWriter)
release(detector)