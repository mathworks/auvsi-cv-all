% Copyright 2014-2015 The MathWorks, Inc
%% Create foreground detector object
detector = vision.ForegroundDetector(...
    'NumTrainingFrames', 20,...
    'InitialVariance', 10*10);

%% Read in video file
reader = vision.VideoFileReader('cad1.mp4',...
    'VideoOutputDataType', 'uint8');

%% Create object for blob analysis
blob = vision.BlobAnalysis('MinimumBlobArea', 1000);

%% Set up video player
player = vision.DeployableVideoPlayer;

%% Foreground detection 

%create loop to run through video
while ~isDone(reader)
    %load next frame
    frame = step(reader);
    %create foreground mask 
    fgMask = step(detector,frame);
    %find bounding box
    [~,~,bbox] = step(blob,fgMask);
    %insert bounding box in frame
    J = insertShape(frame,'rectangle',bbox);
    %update video player  
    step(player,J);
end
    
%% Clean up
release(detector);
release(reader);
release(blob);
release(player);