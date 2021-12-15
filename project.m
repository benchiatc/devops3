%Dataset chosen = TSLA
%% import data
clc;
clear;
ds = tabularTextDatastore('Dataset','FileExtensions','.csv');
ds = transform(ds, @addFilenameToData, 'IncludeInfo', true);
T= readall(ds);
%Pre process data
T = sortrows(T,8);
T.Properties.VariableNames = {'index', 'date', 'close', 'high', 'low', 'open', 'volume','fileName'};
remove_header = T.date == 0;
T(remove_header,:) = [];
index = array2table((0:height(T)-1)');
T(:,1) = index;
dat_open = T.open; %time series data for open prices
%plot(dat_open);

%% Split data
%partition training and test data
numTimeStepsTrain = floor(0.9*length(dat_open));
%numTimeStepsTrain = floor(0.8*length(dat_open));
%numTimeStepsTrain = floor(0.7*length(dat_open));
dataTrain = dat_open(1:numTimeStepsTrain+1)';
dataTest = dat_open(numTimeStepsTrain+1:end)';
%normalize data
mu = mean(dataTrain);
sig = std(dataTrain);
dataTrainStandardized = (dataTrain - mu) / sig;
%prepare predictors and target
XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
rng(123456)
%% define LSTM architecture
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
%training options
options = trainingOptions('adam', ...
    'MaxEpochs',200, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',20, ...
    'LearnRateDropFactor',0.2, ...
    'ValidationPatience',3,...
    'Verbose',0, ...
    'Plots','training-progress',...
    'ExecutionEnvironment','gpu');

%% train network

net = trainNetwork(XTrain,YTrain,layers,options);

%% test the network
%standardize test data
dataTestStandardized = (dataTest - mu) / sig;
XTest = dataTestStandardized(1:end-1);

%test model
net = resetState(net);
net = predictAndUpdateState(net,XTrain);
YPred = [];
numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
end
%restore value of predicted value (unstandardize)
YPred = sig*YPred + mu;
%populate actual response and error
YTest = dataTest(2:end);
rmse = sqrt(mean((YPred-YTest).^2));

%% plot predicted VS actual
figure
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Predicted"],"Location", "southeast")
ylabel("Stock Price($)")
title("Prediction")

subplot(2,1,2)
stem(YPred - YTest)
xlabel("Time")
ylabel("Error")
title("RMSE = " + rmse)
mkdir results
saveas(gcf,'results/chart.png')

% %function to add fileName to datatable for indexing
function [data, info] = addFilenameToData(data, info)
[~, filename, ext] = fileparts(info.Filename);
data.Filename(:, 1) = string([filename ext]);
end