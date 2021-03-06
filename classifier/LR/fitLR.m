function fitLR(xTrain, yTrain, xTest, yTest, nIter)
tic

[NTrain MTrain] = size(xTrain);    % N: samples ; M: features
[NTest MTest] = size(xTest);

% Modify data by inserting column of ones
oneColumnTrain = ones(NTrain, 1);
xTrainTemp = [oneColumnTrain xTrain];
oneColumnTest = ones(NTest, 1);
xTestTemp = [oneColumnTest xTest];

% set w0
w0 = rand(MTrain + 1, 10);

% Training
display('Training...');
if nIter > 0
    % use batch gradient ascent
    weights = LRTrain(xTrainTemp, yTrain, w0, nIter);
else
    % use stochastic gradient ascent
    weights = LRTrainSG(xTrainTemp, yTrain, w0);
end

% Classification
display('Classifying...');
YPredict = LRClassify(xTestTemp, weights);

% evalutaion
yTest = double(yTest);
cMat = confusionmat(yTest, YPredict);
hogAccLRSG = sum(diag(cMat)) / sum(sum(cMat));
display(hogAccLRSG);

toc
end

