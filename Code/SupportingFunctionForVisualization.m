function [singlePredictedVolume, actualVolume, bbox, testImage] = SupportingFunctionForVisualization(condition, condition_numeric, i, j)
    trainedDetector=load('trainedDetector.mat').trainedDetector;
    %Modify condition below when needed 
    fileName = sprintf('test_%d_%d.mat', condition_numeric, i);
    ds = load(fileName).ds;
    tenVolume = load('tenVolume.mat').tenVolume;
    tenVolumeNumeric = load('tenVolumeNumeric.mat').tenVolumeNumeric;
    testVolumeNumeric = load('testVolumeNumeric.mat').testVolumeNumeric;
    detectionResults = detect(trainedDetector, ds, 'SelectStrongest', false, 'MinibatchSize', 10);
    weightedSum = zeros(height(detectionResults), 1);
    fileName = sprintf('D:/Test_sets/%s/ptd_map/%d/image_%d.jpg', condition, i, j);
    testImage = imread(fileName);
    [bboxes, score, ~] = detect(trainedDetector, testImage, 'MiniBatchSize', 128);
    [~, idx] = max(score);
    bbox = bboxes(idx, :);
    %Truth label
    %Computing weighted sum of volume based on probability
    for k=1:height(detectionResults)
        numofPrediction = numel(detectionResults{k, 2}{:});
        labelCorrespondingVolume = zeros(numofPrediction, 1);
        if numofPrediction>=1
            for j=1:numofPrediction
                for jj=1:size(tenVolume, 1)
                    if  detectionResults{k, 3}{:}(j)== tenVolume{jj}
                        labelCorrespondingVolume(j, 1) = tenVolumeNumeric(jj, 1);
                    end
                end
            end                   
        end
        %Predicted volume(unit:m^3)
        weightedSum(k, 1)=sum(detectionResults{k, 2}{:}.*labelCorrespondingVolume)/sum(detectionResults{k, 2}{:})/1000;
        actualVolume = testVolumeNumeric(i, 1);
    end
singlePredictedVolume = weightedSum(j, 1);
end
