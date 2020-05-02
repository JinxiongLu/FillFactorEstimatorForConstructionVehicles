clear
close all
%%%
%Modify parameters below to select a specific image for Visualization
%'4'----->'Condition I'
%'9'----->'Condition VI'
condition = 'The_fifth';
condition_numeric = 5;
%i corresponds to the i_th type of volumes
%j relates to the j_th image
i=18;
j=49;
%%%
%Groundtruth
[singlePredictedVolume, actualVolume, bbox, testImage] = SupportingFunctionForVisualization(condition, condition_numeric, i, j);
Annotation = sprintf('Actual Volume: %f', actualVolume);
outputImage = insertObjectAnnotation(testImage, 'circle', [220, 5, 0.00001], Annotation);
%Detection result
annotation = sprintf('Predicted Volume: %f', singlePredictedVolume);
outputImage = insertObjectAnnotation(outputImage, 'rectangle', bbox, annotation);
figure, imshow(outputImage);
