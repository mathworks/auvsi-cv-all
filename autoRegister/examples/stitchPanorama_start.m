% Copyright 2014-2015 The MathWorks, Inc.
%% Read buoyPanoramaClip.avi
vidReader = vision.VideoFileReader('buoyPanoramaClip.avi',...
    'ImageColorSpace','Intensity');

%% Initialize features for the first frame
grayImage = step(vidReader);
points = detectMSERFeatures(grayImage);
[features,points] = extractFeatures(grayImage,points);

%% Loop through all frames to
% 1. Detect Features
% 2. Extract Features
% 3. Match Features
% 4. Estimate Geometric Transform between frames
idx = 1;

while ~isDone(vidReader)
    
      idx = idx + 1;
    
    % Set previous frame features and points
    
    
    % 1. Detect Features
    
    
    % 2. Extract Features
    
    
    % 3. Match Features
  
    
    % 4. Estimate Geometric Transform between frames 
    
            
end    

%% Find the output limits for each transform


%% Compute the size (width and height) of panorama


%% Map images into the panorama and overlay the images together


% Create a 2-D spatial reference object defining the size of the panorama


%% Create the panorama


%% Clean up
% release(vidReader)
% release(hBlender)