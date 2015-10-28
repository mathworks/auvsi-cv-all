%%importVideoFile
% Acquire and view video from a video file

% Copyright 2014-2015 The MathWorks, Inc.

%% Set up the video file reader
FR = vision.VideoFileReader('vipwarnsigns.avi');

%% Set the reader to output an intensity image
FR.ImageColorSpace = 'RGB';

%% Set the data type of the video output to uint8
FR.VideoOutputDataType = 'uint8';

%% Setup the video player
vidPlayer = vision.DeployableVideoPlayer('Name','RGB Video Player');

%% Acquire video until the video is finished
while (~isDone(FR))
    frame = step(FR);
    step(vidPlayer,frame);
end

%% Cleanup
release(FR);
release(vidPlayer);