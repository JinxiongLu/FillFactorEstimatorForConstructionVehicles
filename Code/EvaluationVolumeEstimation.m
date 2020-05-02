clear
errors = cell(31, 1);
averageError = zeros(31, 1);
RMSE_each_volume = zeros(31, 1);
Error_cat = [];
N = 0;
load('trainedDetector.mat');
hist_cat = [];
%%%%
%Modify condition below when needed
%'4'----->'Condition I'
%'9'----->'Condition VI'
%
condition = 9;
%%%
timerVal = tic;
for i=1:31    
    fileName = sprintf('test_%d_%d.mat', condition, i);
    ds = load(fileName).ds;
    tenVolume = load('tenVolume.mat').tenVolume;
    tenVolumeNumeric = load('tenVolumeNumeric.mat').tenVolumeNumeric;
    testVolumeNumeric = load('testVolumeNumeric.mat').testVolumeNumeric;
    detectionResults = detect(trainedDetector, ds, 'SelectStrongest', false,'MiniBatchSize', 50, 'ExecutionEnvironment', 'gpu');
    weightedSum = zeros(height(detectionResults), 1);
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
    end
    
    %MAPE
    singleVolumeErrors = abs(testVolumeNumeric(i, 1)-weightedSum)/testVolumeNumeric(i, 1);
    sinleAverageError = sum(singleVolumeErrors)/numel(singleVolumeErrors);
    
    singleVolumeErrors_hist = (testVolumeNumeric(i, 1)-weightedSum)/testVolumeNumeric(i, 1);
    
    errors{i, 1} = singleVolumeErrors;
    averageError(i, 1) = sinleAverageError;
    
    hist_cat = cat(1, hist_cat, singleVolumeErrors_hist);
    
    %RMSE
    Error = (testVolumeNumeric(i, 1) - weightedSum);
    Error_cat = cat(1, Error_cat , Error);
    N = N + height(detectionResults);
    %RMSE of each volume    
    RMSE_each_volume(i, 1) = sqrt(sum((testVolumeNumeric(i, 1) - weightedSum).^2)/height(detectionResults));
end
MAPE = sum(averageError)/numel(averageError);
RMSE = sqrt(sum((Error_cat).^2)/N);
processing_time = toc(timerVal)/length(hist_cat);
