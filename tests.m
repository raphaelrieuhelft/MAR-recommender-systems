function tests

M = load('recommendMatrix.txt');
p=0.2;

plainErr = MSE(M,p, 1, @plainSVD)
shiftErr = MSE(M,p, 1, @shiftSVD)
unbiasErr = MSE(M, p, 1, @unbiasedSVD)
witnessErr = MSE(M,p, 1, @witness)
biasMeanErr = MSE(M, p,1, @BiasFromMeanExt)
perUsrAvgData = MSE(M,p,1,@PerUserAverageExt)
end

function [Mh] =  BiasFromMeanExt(X,~,~)
    Mh=BiasFromMean(X);
end
function [Mh] =  PerUserAverageExt(X,~,~)
    Mh=PerUserAverage(X);
end