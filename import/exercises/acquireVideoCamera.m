%%acquireVideoCamera
% Acquire and view video from a video camera

% Copyright 2014-2015 The MathWorks, Inc.

%% Set up the video device object
vidReader = imaq.VideoDevice('winvideo',1);

%% Find the available video formats for your video camera
% Use tab completion or set command
set(vidReader,'VideoFormat')

%% Set the returned video format to 640-by-480, or the closest available resolution
vidReader.VideoFormat = 'MJPG_640x480';

%% Set the returned data type to uint8
vidReader.ReturnedDataType = 'uint8';

%% Setup the deployable video player
vidPlayer = vision.DeployableVideoPlayer;

%% Acquire video for 10 seconds
tic
while (toc<10)
    frame = step(vidReader);
    step(vidPlayer,frame);
end

%% Cleanup
release(vidReader);
release(vidPlayer);