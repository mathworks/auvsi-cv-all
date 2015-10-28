%%acquireImages
% acquire video from a camera

% Copyright 2014-2015 The MathWorks, Inc.

%% Look at available available image acquisition hardware
imaqhwinfo

%% Create new VideoDevice object
myCam = imaq.VideoDevice('winvideo');

%% Set VideoFormat property
myCam.VideoFormat = 'RGB24_640x480';

%% Live video stream of image acquisition device
preview(myCam)

%% Acquire and show a single frame
img = step(myCam);
imshow(img);

%% Acquire images and play the video file using the video player
vidPlayer = vision.DeployableVideoPlayer;
for idx = 1:200
  videoFrame = step(myCam);
  step(vidPlayer, videoFrame);
end

%% Close the video player object
release(myCam);
release(vidPlayer);