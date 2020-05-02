clc
clear
load('trainedDetector.mat');
precision_all = zeros(6, 1);
recall_all = cell(6, 1);
for i=4:9
    j = i-3;
    %Detection result
    fileName = sprintf('ds_detection_%d.mat', i);
    ds = load(fileName).ds;
    detectionResults = detect(trainedDetector, ds,'MiniBatchSize', 50, 'Threshold',0.9, 'ExecutionEnvironment', 'gpu');
    bboxes = detectionResults(:, 1);
    scores = detectionResults(:, 2);
    %keep only the strongest bounding box
    for k=1:height(bboxes)
        if  ~isempty(bboxes{k,1}{1})           
            [~, idx] = max(scores{k, 1}{1});
             bboxes{k,1}{1} = bboxes{k,1}{1}(idx,:);
        end
    end
    
    %Ground truth
    fileName = sprintf('gTruth_detection_%d.mat', i);
    gTruth = load(fileName).gTruth;
    groundTruthBboxes = gTruth.LabelData(:, 1);
    
    [precision, recall] = bboxPrecisionRecall(bboxes,groundTruthBboxes,0.5);
    precision_all(j, 1) = precision;
    recall_all{j, 1} = recall;
end