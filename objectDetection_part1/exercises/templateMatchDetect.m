%% Detect Traffic Sign with Template Matching
% Use Template Matching to detect traffic signs in a scene

% Copyright 2014-2015 The MathWorks, Inc.

%% Use Template Matching to detect a yield sign
clc
clear
close all

% Import images
load templates
load yield2

frame = yield2;
imshowpair(templateYield,frame,'montage'); title('Compare Template vs. Raw Image')

% Initialize template matcher
TM = vision.TemplateMatcher;

% Convert images from rgb to grayscale
templateYieldBm = rgb2gray(templateYield);
frameGray = rgb2gray(frame);

% Calculate location of yield sign in image
tic
locYield = step(TM,frameGray,templateYieldBm);  
toc

% Overlay yield text and marker at location of yield sign
frame = insertShape(frame,'FilledRectangle',[locYield 30 15]);
TI = vision.TextInserter('Location',locYield,'Text','Yield');
frame = step(TI,frame);
frame = insertMarker(frame,locYield);
figure; 
imshow(frame); 
title('Detected Yield Sign');

%% Use a ROI obtained from Blob Analysis to narrow the focus of the Template Matching
clc
clear
close all

% Import images
load templates
load yield2

frame = yield2;
imshowpair(templateYield,frame,'montage'); title('Compare Template vs. Raw Image')

% Initialize template matcher
TM = vision.TemplateMatcher('ROIInputPort',true,'BestMatchNeighborhoodOutputPort',true);

% Convert image from rgb to hsv
yieldHsv = rgb2hsv(frame);
% Create blob analysis object
BO = vision.BlobAnalysis;
% Threshold image
bm = thresholdImage(yieldHsv);
% Perform morphological opening to get rid of noise from flowers
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('octagon',9));
% Perform blob analysis
[area,centroid,bbox]= step(BO,bm);
count = length(area);
% If a sign has been found
if count~=0 
    % Find bounding box
    [amax,aidx] = max(area);
    mbbox = bbox(aidx,:);
    % Convert images from rgb to grayscale
    templateYieldBm = rgb2gray(templateYield);
    frameGray = rgb2gray(frame);
    % Calculate location of yield sign in image
    tic
    locYield = step(TM,frameGray,templateYieldBm,mbbox);  
    toc
    % Overlay yield text and marker at location of yield sign
    frame = insertShape(frame,'FilledRectangle',[locYield 30 15]);
    TI = vision.TextInserter('Location',locYield,'Text','Yield');
    frame = step(TI,frame);
    frame = insertMarker(frame,locYield);
    figure; imshow(frame); title('Detected Yield Sign');
end

%% Use Template Matching to recognize signs in a video
clc
clear 
close all

% Load template images
load templates

% Convert template images to hsv
templateStopHsv = rgb2hsv(templateStop);
templateYieldHsv = rgb2hsv(templateYield);
templateEnterHsv = rgb2hsv(templateEnter);

% Obtain binary mask from hsv template images
templateStopBm = double(thresholdImage(templateStopHsv));
templateYieldBm = double(thresholdImage(templateYieldHsv));
templateEnterBm = double(thresholdImage(templateEnterHsv));

% Initialize video reader
FR = vision.VideoFileReader('vipwarnsigns.avi');
% Initialize video players
VP = vision.DeployableVideoPlayer('Location',[100 100],'Name','Traffic Sign Recognition');
% Initialize template matcher
TM = vision.TemplateMatcher('ROIInputPort',true,'BestMatchNeighborhoodOutputPort',true);
idx = 0;
while(~isDone(FR)) 
    idx = idx + 1;
    % Import image
    frame = step(FR);
    % Convert image from rgb to hsv
    yieldHsv = rgb2hsv(frame);
    % Create blob analysis object
    BO = vision.BlobAnalysis;
    % Tthreshold image
    bm = thresholdImage(yieldHsv);
    % Perform morphological opening to get rid of noise from flowers
    bm = imopen(bm,strel('disk',1));
    bm = imclose(bm,strel('octagon',9));
    % Perform blob analysis
    [area,centroid,bbox]= step(BO,bm);
    count = length(area);
    % If a sign has been found
    if count~=0 
        % Find bounding box
        [amax,aidx] = max(area);
        mbbox = bbox(aidx,:);    
        % Convert rgb to hsv
        frameHsv = rgb2hsv(frame);
        frameBm = double(thresholdImage(frameHsv));
        % Calculate location of traffic sign in image
        [locStop,nvalStop,nvalidStop] = step(TM,frameBm,templateStopBm,mbbox);
        [locYield,nvalYield,nvalidYield] = step(TM,frameBm,templateYieldBm,mbbox); 
        [locEnter,nvalEnter,nvalidEnter] = step(TM,frameBm,templateEnterBm,mbbox);
        % Calculate mean n values 
        nvalMeanStop = mean(nvalStop(:));
        nvalMeanYield = mean(nvalYield(:));
        nvalMeanEnter = mean(nvalEnter(:));
        
        % If traffic sign is found, overlay onto image
        signFound = false;
        if nvalidStop~=0 && nvalMeanStop<300
            location = locStop;
            text = 'Stop';
            signFound = true;
        end
        if nvalidYield~=0 && nvalMeanYield<800
            location = locYield;
            text = 'Yield';
            signFound = true;
        end
        if nvalidEnter~=0 && nvalMeanEnter<500
            location = locEnter;
            text = 'Do Not Enter';
            signFound = true;
        end
        if signFound
            frame = insertShape(frame,'FilledRectangle',[location 7*length(text) 15]);
            TI = vision.TextInserter('Location',location,'Text',text);
            frame = step(TI,frame);   
            frame = insertMarker(frame,location);
        end
        % View next frame
        step(VP,frame)
    end
end
release(FR)
release(VP)
