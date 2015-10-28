function BW = thresholdImage2(RGB)
% Thresholds the white text of a traffic sign out of the image
% Copyright 2014-2015 The MathWorks, Inc.

% Convert RGB image to chosen color space
RGB = im2double(RGB);
cform = makecform('srgb2lab', 'AdaptedWhitePoint', whitepoint('D65'));
I = applycform(RGB,cform);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 51.760;
channel1Max = 99.605;

% Define thresholds for channel 2 based on histogram settings
channel2Min = -15.734;
channel2Max = 16.102;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 1.361;
channel3Max = 13.684;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);