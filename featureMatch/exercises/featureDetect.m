%% Identifying a Traffic Sign with Features
% Use features to count the number of corners on a sign

%% Detect yield sign with features in image
load yield
frameHSV = rgb2hsv(yield);
bm = thresholdImage(frameHSV);
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('disk',10));

% Detect all the corners in the image
corners = detectMinEigenFeatures(bm);
frame = insertMarker(yield,corners,'x');
figure; 
imshow(frame); 
title('Detect All Corners');

% Detect corners with a minimum quality of 0.6
corners = detectMinEigenFeatures(bm,'MinQuality',0.6);
% Overlay number of corners onto image
centroid = mean(corners.Location,1);
text = ['# Corners = ',num2str(corners.Count)];
frame = insertShape(frame,'FilledRectangle',[centroid+[-80 30] 7*length(text) 15]);
TI = vision.TextInserter('Location',centroid+[-80 30],'Text',text);
frame = step(TI,frame);
% If three corners have been found, traffic sign is a yield sign
if corners.Count==3
    frame = insertShape(frame,'FilledRectangle',[centroid 30 15]);
    TI = vision.TextInserter('Location',centroid,'Text','Yield');
    frame = step(TI,frame);
end
figure; 
imshow(frame);
title('Detect Corners with a MinQuality');

%% Detect stop sign with features in image

load stop
frameHSV = rgb2hsv(stop);
bm = thresholdImage(frameHSV);
bm = imopen(bm,strel('disk',1));
bm = imclose(bm,strel('disk',10));

% Detect the corners in the image
corners = detectMinEigenFeatures(bm);
frame = insertMarker(stop,corners,'x');
figure; 
imshow(frame);
title('Detect All Corners');

% Detect corners with a minimum quality of 0.6
corners = detectMinEigenFeatures(bm,'MinQuality',0.94);
frame = insertMarker(stop,corners,'x');
% Overlay number of corners onto image
centroid = mean(corners.Location,1);
text = ['# Corners = ',num2str(corners.Count)];
frame = insertShape(frame,'FilledRectangle',[centroid+[-80 30] 7*length(text) 15]);
TI = vision.TextInserter('Location',centroid+[-80 30],'Text',text);
frame = step(TI,frame);
if corners.Count==8
    frame = insertShape(frame,'FilledRectangle',[centroid 30 15]);
    TI = vision.TextInserter('Location',centroid,'Text','Stop');
    frame = step(TI,frame);
end
figure; 
imshow(frame); 
title('Detect Corners with MinQuality');

%% Recognize stop signs with features in video
clc
clear
close all

FR = vision.VideoFileReader('vipwarnsigns.avi');
VP = vision.DeployableVideoPlayer('Location',[100 500],'Name','Raw Video');
VP2 = vision.DeployableVideoPlayer('Location',[100 300],'Name','Binary Mask');
VP3 = vision.DeployableVideoPlayer('Location',[100 100],'Name','Features');
BA = vision.BlobAnalysis('MinimumBlobArea',10);
idx = 0;

while(~isDone(FR)) 
    close all
    idx = idx + 1;
    frame = step(FR);
    % Convert to hsv
    frameHSV = rgb2hsv(frame);
    % Extract binary mask
    bm = thresholdImage(frameHSV);
    bm = imopen(bm,strel('disk',1));
    bm = imfill(bm,'holes');
    bm = imclose(bm,strel('octagon',9));
    % Perform blob analysis to obtain ROI
    [area,centroid,bbox] = step(BA,bm);
    count = length(area);
    if count~=0
        [amax,aidx] = max(area);
        % Detect features with min quality
    	corners = detectMinEigenFeatures(bm,'ROI',bbox(aidx,:),'MinQuality',0.6);
        frame = insertMarker(frame,corners,'x');
        if corners.Count~=0
            centroid = mean(corners.Location,1);
            location = centroid + [-80 30];
            text = ['# Corners = ',num2str(corners.Count)];
            frame = insertShape(frame,'FilledRectangle',[location 7*length(text) 15]);
            TI = vision.TextInserter('Location',location,'Text',text);
            frame = step(TI,frame);            
            if corners.Count==1
                text = 'Do Not Enter';
            elseif corners.Count==3
                text = 'Yield';
            elseif corners.Count==8
                text = 'Stop';
            end   
            % overlay text onto video
            frame = insertShape(frame,'FilledRectangle',[centroid 7*length(text) 15]);
            TI = vision.TextInserter('Location',centroid,'Text',text);
            frame = step(TI,frame);
            % view next frame
            step(VP3,frame)
        end
    end
end
release(FR)
release(VP)
