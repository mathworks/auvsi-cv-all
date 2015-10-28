% Copyright 2014-2015 The MathWorks, Inc.

%% Read the first image, convert it to grayscale, detect and extract features
I = imread('map01.png');
Igray = rgb2gray(I);
points = detectMinEigenFeatures(Igray);
[features, points] = extractFeatures(Igray, points);

%% In every iteration we calculate the transformation matrix and the output 
% Output limits. Pre-allocate memory for all three outputs. The
% transformation matrix is initialized by the identity transformation.
numImages = 8;
tforms(numImages) = projective2d(eye(3));
xOutLim = ones(numImages,2);
yOutLim = ones(numImages,2);

%% Estimate the transformation matrices 
for k = 2:numImages
    
    fprintf('Estimating matrix for image nr %d\n',k);

    % Save features from previous iteration
    pointsPrevious = points;
    featuresPrevious = features;

    % Read next image and convert it to grayscale
    I = imread(sprintf('map%02d.png',k)); 
    Igray = rgb2gray(I);
    [height,width] = size(Igray);
    
    % Detect and extract features
    points = detectMinEigenFeatures(Igray);
    [features, points] = extractFeatures(Igray, points);
    
    % Match extracted features
    indexPairs = matchFeatures(features, featuresPrevious,'MaxRatio',0.7,'Unique', true);
    
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);
    
    % Calculate transformation matrix
    tforms(k) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99, 'MaxNumTrials', 2000);
    
    % Compute T(1) * ... * T(k-1) * T(k)
    tforms(k).T = tforms(k-1).T * tforms(k).T;
    
    % Calculate the outputlimits
    [xOutLim(k,:),yOutLim(k,:)] = outputLimits(tforms(k),[1,width],[1,height]);
end

%% Determine the size of the complete panorama.

% Find the minimum and maximum output limits. 
xMin = min([1; xOutLim(:)]);
xMax = max([width; xOutLim(:)]);

yMin = min([1; yOutLim(:)]);
yMax = max([height; yOutLim(:)]);

xLimits = [xMin xMax];
yLimits = [yMin yMax];

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);

% Display empty panorama in a new figure
figure
imshow(panorama)
ahImg = gca;

% Create a 2-D spatial reference object defining the size of the panorama.
panoramaView = imref2d([height width], xLimits, yLimits);

% Create a alpha blender object for combining images
blender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

%% Create the panorama by transforming all images and blend them
for k = 1:numel(tforms)
    
    I = imread(sprintf('map%02d.png',k));
    
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(k), 'OutputView', panoramaView);
    
    % Create an mask for the overlay operation.
    warpedMask = imwarp(ones(size(I(:,:,1))), tforms(k), 'OutputView', panoramaView);
    
    % Clean up edge artifacts in the mask and convert to a binary image.
    warpedMask = warpedMask >= 1;
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, warpedMask);
    
    imshow(panorama,'Parent',ahImg)
    drawnow
end