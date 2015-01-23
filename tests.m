function tests

addpath('CF-Reference')
addpath('SVD')
addpath('SlopeOne')

M = load('recommendMatrix.txt');
p=0.2;

plainErr = MSE(M,p, 1, @plainSVD)
shiftErr = MSE(M,p, 1, @shiftSVD)
unbiasErr = MSE(M, p, 1, @unbiasedSVD)
witnessErr = MSE(M,p, 1, @witness)
biasMeanErr = MSE(M, p,1, @BiasFromMeanExt)
perUsrAvgErr = MSE(M,p,1,@PerUserAverageExt)
userCosErr = MSE(M,p,1,@UserCosSimExt)
itemCosErr = MSE(M,p,1,@ItemCosSimExt)
SlopeOneErr = MSE_1arg(M,p,1,@SlopeOne)
WeightedSlopeOneErr = MSE_1arg(M,p,1,@WeightedSlopeOne)

end

function [err] =  MSE_1arg(M,p,iter,f)
    function Mh = Ext(M,~,~)
        Mh = f(M);
    end
    err = MSE(M,p,iter,@Ext);
end
function [Mh] =  BiasFromMeanExt(X,~,~)
    Mh=BiasFromMean(X);
end
function [Mh] =  PerUserAverageExt(X,~,~)
    Mh=PerUserAverage(X);
end
function[Mh] = UserCosSimExt(X,~,~)
    Mh=userCosSimilarity(X);
end
function[Mh] = ItemCosSimExt(X,~,~)
    Mh=itemCosSimilarity(X);
end
function[Mh] = SlopeOneExt(X,~,~)
    Mh=SlopeOne(X);
end