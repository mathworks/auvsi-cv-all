%% Blob Analysis for a Traffic Sign
% Use blob analysis with insert functions to overlay bounding box over
% traffic sign

% Copyright 2014-2015 The MathWorks, Inc.

%% Extract red traffic sign from mat file
% Import image
load frame
figure; imshow(frame)
frameHSV = rgb2hsv(frame);
% Threshold to obtain binary mask
bm = thresholdImage(frameHSV);
% Perform morphological opening to get rid of noise from flowers
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('octagon',9));
figure; imshow(bm)
% Perform blob analysis
BA = vision.BlobAnalysis('MinimumBlobArea',10);
[area,centroid,bbox] = step(BA,bm);
[amax,aidx] = max(area);
% Overlay bbox onto image
frame = insertShape(frame,'Rectangle',bbox(aidx,:));
% Overlay area of biggest blob onto image
frame = insertShape(frame,'FilledRectangle',[centroid(aidx,:) 80 15]);
TI = vision.TextInserter('Text',['Area = ',num2str(max(area))],'Location',uint16(centroid(aidx,:)));
frame = step(TI,frame);
% View frame
imshow(frame);

%% Extract red traffic sign from video
FR = vision.VideoFileReader('vipwarnsigns.avi');
VP = vision.DeployableVideoPlayer('Location',[100 300]);
VP2 = vision.DeployableVideoPlayer('Location',[500 300]);
BA = vision.BlobAnalysis('MinimumBlobArea',10);
idx = 0;
while(~isDone(FR))   
    idx = idx + 1;
    frame = step(FR);
    frameHSV = rgb2hsv(frame);
    % Threshold to obtain binary mask 
    bm = thresholdImage(frameHSV);
    % Perform morphological opening to get rid of noise from flowers
    bm = imopen(bm,strel('disk',1));
    bm = imclose(bm,strel('octagon',9));
    % Perform blob analysis
    [area,centroid,bbox] = step(BA,bm);
    count = length(area);
    if count~=0
    	% Overlay bbox onto image
        [amax,aidx] = max(area);
        frame = insertShape(frame,'Rectangle',bbox(aidx,:));
        % Overlay area of biggest blob onto image
        frame = insertShape(frame,'FilledRectangle',[centroid(aidx,:) 80 15]);
        TI = vision.TextInserter('Location',uint16(centroid(aidx,:)),'Text',['Area = ',num2str(amax)]);
        frame = step(TI,frame); 
    end
    % View next frame
    step(VP,frame);
end
release(FR)
release(VP)