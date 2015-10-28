%%playVideoFile

% Copyright 2014-2015 The MathWorks, Inc.

%% Read video frames from the buoyRun.avi file.
vidFReader = vision.VideoFileReader('buoyRun.avi');

%% Explore VideoDevice object properties
properties(vidFReader)

%% Set VideoOutputDataType property
vidFReader.VideoOutputDataType = 'double';

%% Explore VideoDevice object methods
methods(vidFReader)

%% Get a single frame of the video
videoFrame = step(vidFReader);
imshow(videoFrame);

%% Reset the videoFReader to the beginning of the file
reset(vidFReader);

%% Play the video file using imshow
tic
while ~isDone(vidFReader)
  videoFrame = step(vidFReader);
  imshow(videoFrame)
end
imshowTime = toc

reset(vidFReader);

%% Play the video file using the video player
vidPlayer = vision.DeployableVideoPlayer;

tic
while ~isDone(vidFReader)
  videoFrame = step(vidFReader);
  step(vidPlayer, videoFrame);
end
vPlayerTime = toc

reset(vidFReader);

%% Increase the video player size to see the full video
%  Retrieve the screen size in pixels
r = groot;
scrPos = r.ScreenSize;

%  Position is a 4-element vector: 
%  [left bottom height width]
left = scrPos(3)*(1/2);
bottom = scrPos(4)*(1/2);
height = 640;
width = 480;

vidPlayer = vision.VideoPlayer('Position',...
    [left bottom height width]);

while ~isDone(vidFReader)
  videoFrame = step(vidFReader);
  step(vidPlayer, videoFrame);
end

release(vidPlayer);
reset(vidFReader);

%% Get the 15th frame of the video
for idx = 1:90
  videoFrame = step(vidFReader);
end
imshow(videoFrame);

%% Release objects
release(vidPlayer);
release(vidFReader);