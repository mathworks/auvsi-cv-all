This MATLAB FileExchange entry contains files related to the "Object Detection : Part 1" video of the AUVSI Foundation: Computer Vision Training.

examples - Files used in the video
[~] TemplateMatching.m : Example MATLAB code file to detect objects (bikes) using template matching method.
[~] bikeTemplate.mat : Example template image for template matching.
[~] InputTM1.mat : Example data with input image to test object detector.
[~] InputTM2.mat : Example data with input image to test object detector.
[~] InputTM3.mat : Example data with input image to test object detector.
[~] InputTM4.mat : Example data with input image to test object detector.
[~] HOGVisualization.m : Example MATLAB code file to visualize HOG features.
[~] InputHOG.mat : Example data with input image to visualize HOG features.
[~] CODTraining.m : Example MATLAB code file to train a Cascade Object Detector.
		    (Note:Please make sure 'database' folder exists for training images. If it does not
		     look at getImageDatabase.m)
[~] BikePositive.mat : Example data with region of interest (ROI) defined for positive training instances (bikes).
[~] HOGDetectImage.m : Example MATLAB code file to detect objects (bikes) in an image
		       using Cascade Object Detector.
[~] HOGDetectVideo.m : Example MATLAB code file to detect objects (bikes) in a video
		       using Cascade Object Detector. (Note: Run this file with different XML files in the 
		       XML Files (Folder) to generate various results)
[~] ValidationScript.m : Example MATLAB code file to validate various Cascade Object Detectors.
       		         (Note:Please make sure 'ValidationSet' folder exists for validation images)
[~] VisNumStages.m: Utility MATLAB code file to visualize validation results based on # of stages.
[~] VisFalseAlarm.m: Utility MATLAB code file to visualize validation results based on False Alarm Rates.
[~] bikeTorr.mp4 : Example input video to test Cascade Object Detector.
[~] XML Files (Folder) : Contains XML files corresponding to detectors with different # of stages (NumStages)
			 and False Alarm Rates (FAR). (Naming: bikedetector_NumStages_FAR.xml)
[~] database (Folder) : Contains bike and non bike images for training Cascade Object Detector. All images 
from this folder were obtained from the following database: http://www.emt.tugraz.at/~pinz/data/GRAZ_02/
[~] ValidationSet (Folder) : Contains images for validation script.

exercises - Files for exercise and practice tasks
[~] auvsi_ipcv_exercises_05_note.pdf : Note introducing the exercise tasks and presenting respective solutions
[~] templateMatchDetect.m : Solution MATLAB code file for the exercise "Detect Traffic Sign with
Template Matching"
[~] cascadeObjectDetect.m : Solution MATLAB code file for the exercise "Detect Traffic Sign with
			    Cascade Object Detection"
[~] thresholdImage.m : Helper MATLAB function which thresholds the given image to extract the red background of a 		                       traffic sign
[~] stop.mat : MAT-file with a video frame showing a stop sign
[~] yield2.mat : MAT-file with a video frame showing a yield sign
[~] templates.mat : MAT-file with template images for traffic signs
[~] stopSignDetector.xml : Provided for cascade object detector trained with small negative images folder in "Detect 			                   Traffic Sign with Cascade Object Detection" exercise 
[~] stopSignDetector2.xml : Provided for cascade object detector trained with large negative images folder in "Detect 			                    Traffic Sign with Cascade Object Detection" exercise 
[~] nonStopSignImagesLarge (Folder) : Contains non-stop sign images used for training cascade object detector in "Detect 	                              Traffic Sign with Cascade Object Detection" exercise 
