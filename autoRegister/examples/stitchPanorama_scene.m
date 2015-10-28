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
    pointsPrev = points;
    featuresPrev = features;
    
    % 1. Detect Features
    grayImage = step(vidReader);
    points = detectMSERFeatures(grayImage);
    
    % 2. Extract Features
    [features,points] = extractFeatures(grayImage,points);
    
    % 3. Match Features
    indexPairs = matchFeatures(features,featuresPrev);
    matchedPoints = points(indexPairs(:,1),:);
    matchedPointsPrev = pointsPrev(indexPairs(:,2),:);
    
    % 4. Estimate Geometric Transform between frames 
    tforms(idx) = estimateGeometricTransform...
        (matchedPoints,matchedPointsPrev,'projective');
    
    tforms(idx).T = tforms(idx-1).T * tforms(idx).T;
            
end    

%% Find the output limits for each transform
imgSize = size(grayImage);
xMin = 1;
xMax = imgSize(2);
yMin = 1;
yMax = imgSize(1);

for idx = 1:numel(tforms)
    
    [xLimit,yLimit] = outputLimits(tforms(idx),...
        [1 imgSize(2)], [1 imgSize(1)]);
    xMin = min(xMin,xLimit(1));
    xMax = max(xMax,xLimit(2));
    yMin = min(yMin,yLimit(1));
    yMax = max(yMax,yLimit(2));
    
end


%% Compute the size (width and height) of panorama
width = round(xMax - xMin);
height = round(yMax - yMin);

%% Map images into the panorama and overlay the images together
hBlender = vision.AlphaBlender('Operation','Binary mask',...
    'MaskSource','Input port');

% Create a 2-D spatial reference object defining the size of the panorama
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width],xLimits,yLimits);

%% Create the panorama
panorama = zeros([height width],'single');
reset(vidReader)
idx = 1;

while ~isDone(vidReader)
    
    grayImage = step(vidReader);
    warpedImage = imwarp(grayImage,tforms(idx),'OutputView',panoramaView);
    warpedMask = warpedImage > 0;
    
    panorama = step(hBlender,panorama,warpedImage,warpedMask);
    
    figure(1)
    imshow(panorama)
    
    idx = idx + 1;
end
 
%% Clean up
release(vidReader)
release(hBlender)