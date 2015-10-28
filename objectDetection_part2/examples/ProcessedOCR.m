% Copyright 2014-2015 The MathWorks, Inc
%% Load original input image
load sign1

%% Color Threshold input image

% Convert RGB image to chosen color space
I = rgb2ycbcr(In);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 215.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 255.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

%% Perform morphological open operation
se = strel('disk',3);
BW = imopen(BW,se);

%% View BW image
imshow(BW)

%% Perform OCR on BW image
results = ocr(BW);

%% Insert detected text in image 
TI = vision.TextInserter(results.Text, 'FontSize', 34,...
    'Location', [700 100]);
K = step(TI,In);

%% Visualize results
figure
imshow(K)

%% Clean up
release(TI)