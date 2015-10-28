% Copyright 2014-2015 The MathWorks, Inc
%% Load positive images and bounding boxes of bikes
load BikePositive

%% Step 2: Specify folder with negative images
negativeFolder = [pwd '\database\nonbike'];

%% Step 3: Train the detector
NumStages = 5;
FAR = 0.05;

trainCascadeObjectDetector('bikedetector_5_5.xml', Bike, negativeFolder,...
    'NumCascadeStages', NumStages, 'FalseAlarmRate', FAR);