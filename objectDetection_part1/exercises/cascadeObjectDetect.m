%% Detect Traffic Sign with Cascade Object Detector

% Copyright 2014-2015 The MathWorks, Inc.

%% Train Cascade Object Detector 
% Load positive instances
load stopSigns
positiveInstances = data;
% Add folder corresponding to positive images to the path
positiveFolder = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
addpath(positiveFolder);
% Specify negative folder
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');
% Specify xml file
detectorFile = 'stopSignDetector.xml';
% Train cascade object detector
tic
trainCascadeObjectDetector(detectorFile, ...
                         positiveInstances, negativeFolder,...
                         'FalseAlarmRate', 0.1,'NumCascadeStages', 5);
toc

%% Run trained detector on image
% Load test image
load stop
frame = stop;
figure; imshow(img);
% Specify xml file
detectorFile = 'stopSignDetector.xml';
% Initialize cascade object detector
detector = vision.CascadeObjectDetector(detectorFile);
% Perform cascade object detection 
bbox = step(detector, frame);
% Overlay results onto image and view
frame = insertShape(frame,'Rectangle',bbox);
textLocation = bbox(1:2)+[0 -15];
frame = insertShape(frame,'FilledRectangle',[textLocation 30 15]);
TI = vision.TextInserter('Location',textLocation,'Text','Stop');
frame = step(TI,frame);
figure; imshow(frame);

%% Run trained detector on video
% Initialize cascade object detector
detectorFile = 'stopSignDetector.xml';
stopsignDetector = vision.CascadeObjectDetector(detectorFile,'MaxSize',[75 75]);
% Initialize 
FR = vision.VideoFileReader('vipwarnsigns.avi','VideoOutputDataType','uint8');
VP = vision.DeployableVideoPlayer;
frame = step(FR);
step(VP,frame);
idx = 0;
while ~isDone(FR)
    idx = idx + 1;
    frame = step(FR);
    bbox = step(stopsignDetector,frame);
    count = size(bbox,1);
    % If stop sign has been found, annotate frame
    if count
        frame = insertShape(frame,'Rectangle',bbox);
        textLocation = bbox(1:2)+[0 -15];
        frame = insertShape(frame,'FilledRectangle',[textLocation 30 15]);
        TI = vision.TextInserter('Location',textLocation,'Text','Stop');
        frame = step(TI,frame);
    end
    % View frame
    step(VP,frame);
end

%% Retrain Cascade Object Detector with larger Negative Image Folder to Remove False Positives
% Load positive instances
load stopSigns
positiveInstances = data;
% Add folder corresponding to positive images to the path
positiveFolder = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
addpath(positiveFolder);
% Specify negative folder
negativeFolder = fullfile(pwd,'nonStopSignImagesLarge');
% Specify xml file
detectorFile = 'stopSignDetector2.xml';
% Train cascade object detector
tic
trainCascadeObjectDetector(detectorFile, ...
                         positiveInstances, negativeFolder,...
                         'FalseAlarmRate', 0.001,'NumCascadeStages', 5);
toc

%% Run trained detector on video with larger Negative Image Folder to Remove False Positives
% Specify xml file
detectorFile = 'stopSignDetector2.xml';
% Create cascade object detector
stopsignDetector = vision.CascadeObjectDetector(detectorFile,'MaxSize',[75 75]);

FR = vision.VideoFileReader('vipwarnsigns.avi','VideoOutputDataType','uint8');
VP = vision.DeployableVideoPlayer;
idx = 0;
while ~isDone(FR)
    idx = idx + 1;
    frame = step(FR);
    bbox = step(stopsignDetector,frame);
    count = size(bbox,1);
    % If stop sign has been found, annotate frame
    if count
        frame = insertShape(frame,'Rectangle',bbox);
        textLocation = bbox(1:2)+[0 -15];
        frame = insertShape(frame,'FilledRectangle',[textLocation 30 15]);
        TI = vision.TextInserter('Location',textLocation,'Text','Stop');
        frame = step(TI,frame);
    end
    % View frame
    step(VP,frame);
end
%% Cleanup
% Remove folder corresponding to positive images to the path
positiveFolder = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
rmpath(positiveFolder);