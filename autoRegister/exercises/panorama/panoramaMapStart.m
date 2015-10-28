% Copyright 2014-2015 The MathWorks, Inc.

%% TODO:
% Read the first image
% Convert it to grayscale
% Detect and extract features

%% In every iteration we calculate the transformation matrix and the output 
% Output limits. Pre-allocate memory for all three outputs. The
% Transformation matrix is initialized by the identity transformation.
numImages = 8;
tforms(numImages) = projective2d(eye(3));
xOutLim = ones(numImages,2);
yOutLim = ones(numImages,2);

%% TODO: Inside a loop read images and estimate the transformation matrices 
% Start reading with the second image. We already have the tranformation
% matrix for the first image (the identity transformation).
    
    % Save features from previous iteration
    pointsPrevious = points;
    featuresPrevious = features;

    % TODO: 
    % Read next image
    % Convert it to grayscale
    % Calculate size of image
    
    % TODO: Detect and extract features
   
    % TODO: Match extracted features
        
    % TODO: Calculate transformation matrix

    % Compute T(1) * ... * T(k-1) * T(k)
    tforms(k).T = tforms(k-1).T * tforms(k).T;
    
    % Calculate the outputlimits
    [xOutLim(k,:),yOutLim(k,:)] = outputLimits(tforms(k),[1,width],[1,height]);

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

% TODO: Initialize the "empty" panorama.

% TODO: Display empty panorama in a new figure

% TODO: Create a 2-D spatial reference object defining the size of the panorama
% and the x and y limits calculated above.

% Create a alpha blender object for combining images
blender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

%% Create the panorama by transforming all images and blend them
% TODO: loop over all transformation matrices and transform the input image

    % TODO: Read k-th image
    
    % TODO: Transform image into the panorama. 
    
    % Create an mask for the overlay operation.
    warpedMask = imwarp(ones(size(I(:,:,1))), tforms(k), 'OutputView', panoramaView);
    
    % Clean up edge artifacts in the mask and convert to a binary image.
    warpedMask = warpedMask >= 1;
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, warpedMask);
    
    % TODO: display the panorama
