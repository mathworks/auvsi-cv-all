%%allFramesBlob

% Copyright 2014-2015 The MathWorks, Inc.

%% Setup
% Create object to read video frames from the buoyRun.avi file
vidReader = vision.VideoFileReader('buoyRun.avi');
vidReader.VideoOutputDataType = 'double';

% Create structural element for morphological operations to remove disturbances
diskElem = strel('disk',3);

% Create a BlobAnanlysis object to calculate detected objects’ area, 
% centroid, major axis length and label matrix. 
hBlob = vision.BlobAnalysis('MinimumBlobArea',200,...
    'MaximumBlobArea',5000);

%Create TextInserter object to insert # of objects detected
hTextIns = vision.TextInserter('%d','Location',[20 20],...
    'Color',[255 255 0],'FontSize',30);

% Create VideoPlayer
vidPlayer = vision.DeployableVideoPlayer;

%% Run the algorithm in a loop
while ~isDone(vidReader)
    
    % Read Frame
    vidFrame = step(vidReader);
  
    % Convert RGB image to chosen color space
    Ihsv = rgb2hsv(vidFrame);

    % Define thresholds for channel 1 based on histogram settings
    channel1Min = 0.398;
    channel1Max = 0.498;
    
    % Define thresholds for channel 2 based on histogram settings
    channel2Min = 0.355;
    channel2Max = 1.000;
    
    % Define thresholds for channel 3 based on histogram settings
    channel3Min = 0.000;
    channel3Max = 1.000;

    % Create mask based on chosen histogram thresholds
    Ibw = (Ihsv(:,:,1) >= channel1Min ) & (Ihsv(:,:,1) <= channel1Max) & ...
        (Ihsv(:,:,2) >= channel2Min ) & (Ihsv(:,:,2) <= channel2Max) & ...
        (Ihsv(:,:,3) >= channel3Min ) & (Ihsv(:,:,3) <= channel3Max);
    
    % Use morphological operations to remove disturbances
    Ibwopen = imopen(Ibw,diskElem);
    
    % Extract the blobs from the frame 
    [areaOut,centroidOut,bboxOut] = step(hBlob, Ibwopen);
    
    % Draw a box around the detected objects
    Ishape = insertShape(vidFrame,'Rectangle',bboxOut);
    
    % Insert a string of number of objects detected in the video frame.
    numObj = length(areaOut);
    
    Itext = step(hTextIns,Ishape,int32(numObj));

    %Play in the video player
    step(vidPlayer, Itext);

end

%% Cleanup
release(vidReader)
release(hBlob)
release(hTextIns)
release(vidPlayer)