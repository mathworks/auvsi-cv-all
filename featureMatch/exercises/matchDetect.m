%% Detect Traffic Sign with Matched Features
% Determine the location of template in a scene using feature matching

%% Match template in scene to find yield sign
clc
clear
close all

% Import images
load template
load yield2
scene = yield2;
% Convert full to grayscale
scene = rgb2gray(scene);
% Detect features
corners1 = detectMinEigenFeatures(template);
corners2 = detectMinEigenFeatures(scene);
figure; 
imshowpair(insertMarker(template,corners1),insertMarker(scene,corners2),'montage');
title('Corner Points');

% Extract features
[features1, valid_points1] = extractFeatures(template, corners1);
[features2, valid_points2] = extractFeatures(scene, corners2);
figure; 
imshowpair(insertMarker(template,valid_points1),insertMarker(scene,valid_points2),'montage'); 
title('Valid Points');

% Match features
indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);

figure; 
showMatchedFeatures(template, scene, matchedPoints1, matchedPoints2,'montage');
title('detectMinEigenFeatures')

%% Match template in video to find yield sign
clc
clear 
close all

% Detect features in template image
load template
corners1 = detectMinEigenFeatures(template);
[features1, valid_points1] = extractFeatures(template, corners1,'Method','Block');

% Create system objects
FR = vision.VideoFileReader('vipwarnsigns.avi');
VP = vision.DeployableVideoPlayer('Location',[100 500],'Name','Raw Video');
VP2 = vision.DeployableVideoPlayer('Location',[100 300],'Name','Binary Mask');
VP3 = vision.DeployableVideoPlayer('Location',[100 100],'Name','Features');
BA = vision.BlobAnalysis('MinimumBlobArea',10);
idx = 0;
while(~isDone(FR)) 
    idx = idx + 1;
    % Import image
    frame = step(FR);
    % Convert RGB to grayscale
    scene = rgb2gray(frame);
    % Detect features
    corners2 = detectMinEigenFeatures(scene);
    % Extract features
    [features2, valid_points2] = extractFeatures(scene, corners2,'Method','Block');
    % Match features
    [indexPairs,matchMetric] = matchFeatures(features1,features2);    
    % Extract matched points
    matchedPoints1 = valid_points1(indexPairs(:, 1), :);
    matchedPoints2 = valid_points2(indexPairs(:, 2), :);
    % Overlay data onto video
    if matchedPoints2.Count>=2
        location = mean(matchedPoints2.Location,1);
        count = size(location,1);
        frame = insertShape(frame,'FilledRectangle',[location 30 15]);
        TI = vision.TextInserter('Location',location,'Text','Yield');
        frame = step(TI,frame);
        frame = insertMarker(frame,mean(matchedPoints2.Location,1));
    end
    % View next frame
    step(VP,frame)
end
release(FR)
release(VP)
