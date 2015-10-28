% Copyright 2014-2015 The MathWorks, Inc
%% Load input image and view it
load sign1
imshow(In)

%% Select ROI

% Get ROI interactively
roi = round(getPosition(imrect));

%OR

% Provide ROI directly in script
roi = [364,253,363,410];

%% Perform OCR on image

% Without ROI
results = ocr(In);

% OR

% With ROI
results = ocr(In,roi);

%% Insert bounding boxes on detected words in image
J = insertShape(In,'rectangle',results.WordBoundingBoxes,...
    'LineWidth', 3);
imshow(J)

%% Insert detected text in image 
TI = vision.TextInserter(results.Text,'FontSize', 34,'Location', [700 100]);
K = step(TI,J);
imshow(K)

%% Clean up
release(TI)