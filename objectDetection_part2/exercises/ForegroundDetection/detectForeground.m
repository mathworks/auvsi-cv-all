% Copyright 2014-2015 The MathWorks, Inc.
%% Create the video reader and setup the video player
FR = vision.VideoFileReader('ballsGrayscale.avi','ImageColorSpace','Intensity','VideoOutputDataType','uint8');

VP = vision.DeployableVideoPlayer;

% Setup the foreground detector
FD = vision.ForegroundDetector(...
       'NumTrainingFrames', 10, ... 
       'InitialVariance', 50*50,...
       'MinimumBackgroundRatio',0.9,...
       'NumGaussians',5);    
   
% Remove small objects and objects touching the border. Return the bounding-box only.
BA = vision.BlobAnalysis(...
       'CentroidOutputPort', false, 'AreaOutputPort', false, ...
       'BoundingBoxOutputPort', true, ...
       'MinimumBlobArea', 2000,'ExcludeBorderBlobs',true);

% Process all frames in a loop
while ~isDone(FR)
     frame  = step(FR);
     % Detect foreground
     bm = step(FD, frame);
     % Calculate bounding box
     bbox   = step(BA, bm);
     % Draw bounding boxes around balls
     frame    = insertShape(frame,'Rectangle',bbox); 
     step(VP, frame); % view results in the video player
end

% Release video reader and player
release(VP);
release(FR);