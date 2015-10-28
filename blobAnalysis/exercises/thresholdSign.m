%% Thresholding a Traffic Sign
% Use combination of thresholding, morphologing opening and closing to
% obtain full traffic sign

% Copyright 2014-2015 The MathWorks, Inc.

%% Extract red traffic sign from mat file
% Import image
load frame
figure; imshow(frame)
% Convert frame from rgb 2 hsv
frameHSV = rgb2hsv(frame);
% Threshold image
bm = thresholdImage(frameHSV);
% Perform morphological opening to get rid of noise from flowers
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('octagon',9));
figure; imshow(bm)

%% Extract red traffic sign from video
FR = vision.VideoFileReader('vipwarnsigns.avi');
VP = vision.DeployableVideoPlayer('Location',[100 300]);
VP2 = vision.DeployableVideoPlayer('Location',[500 300]);
while(~isDone(FR))    
    frame = step(FR);
    step(VP,frame)
    % Convert frame from rgb to hsv
    frameHSV = rgb2hsv(frame);
    % Threshold image
    bm = thresholdImage(frameHSV);
    % Perform morphological opening to get rid of noise from flowers
    bm = imopen(bm,strel('disk',1));
    bm = imclose(bm,strel('octagon',9));
    step(VP2,bm)
end
release(FR)
release(VP)