% Copyright 2014-2015 The MathWorks, Inc
%% Setup
clc
clear
close all
addpath('ValidationSet')
addpath('XML Files')

%% Creating variable to set truth values
valFiles = dir('ValidationSet');
valFiles = valFiles(3:end); %Remove first 2 elements from output of dir command
bike = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1]; %Change according to dataset

%% Creating initial table for results
NumStages = [5*ones(4,1);7*ones(4,1);9*ones(4,1);11*ones(4,1);13*ones(4,1);15*ones(4,1)];
FalseAlarmRates = repmat([0.1;0.075;0.05;0.025],6,1);
TP = zeros(24,1);
FP = zeros(24,1);
FN = zeros(24,1);
TN = zeros(24,1);

statsTable = table(NumStages,FalseAlarmRates,TP,FP,FN,TN);


%% Detection
for n = 1:24
    
    % Update XML file name
    XMLFile = ['bikedetector_' num2str(NumStages(n)) '_' num2str(FalseAlarmRates(n)*1000) '.xml'];
        
    % Using the XML for detection
    detector = vision.CascadeObjectDetector(XMLFile);
    TruePositive = 0;   % Detecting bike in positive image
    FalsePositive = 0;  % False alarms
    FalseNegative = 0;  % Misses 
    TrueNegative = 0;   % Not detecting bike in negative image
    
    % Loop through 24 test images
    for k = 1:24 
        % Update image name
        filename = valFiles(k).name;
        I = imread(filename);
             
        % Find the bounding box
        bbox = step(detector,I);
        detect = size(bbox,1);
        
        if (bike(k) == 1)
            if (detect >= 1)
                TruePositive = TruePositive + 1;
                FalsePositive = FalsePositive + (detect-1);
            else
                FalseNegative = FalseNegative + 1;
            end
        else
            if (detect >= 1)
                FalsePositive = FalsePositive + detect;
            else
                TrueNegative = TrueNegative + 1;
            end
        end
    end
    
    statsTable.TP(n) = TruePositive;
    statsTable.FP(n) = FalsePositive;
    statsTable.FN(n) = FalseNegative;
    statsTable.TN(n) = TrueNegative;    
end


%% Visualization of results
VisFalseAlarm
VisNumStages
