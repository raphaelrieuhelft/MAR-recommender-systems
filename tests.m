function tests

addpath('CF-Reference')
addpath('SVD')
addpath('SlopeOne')
addpath('ErrorRating')

M = load('recommendMatrix.txt');
p=0.2;
iter=1;

algos = {
    'Witness', @witness;
    'UnbiasedWitness', @UnbiasedWitness;

    'PerUserAverage', @PerUserAverageExt;
    'BiasFromMean', @BiasFromMeanExt;
    
    'PlainSVD', @plainSVD;
    'ShiftSVD', @shiftSVD;
    'UnbiasedSVD', @unbiasedSVD;
    
    'UserCosSi', @UserCosSimExt;
    'ItemCosSim', @ItemCosSimExt;
    
    'SlopeOn', @SlopeOneExt;
    'WeightedSlopeOn', @WeightedSlopeOneExt
    }


errors = cellfun(@(algo) MSE(M,p,iter,algo), algos(:,2));
errors = num2cell(errors);

results = [algos(:,1), errors]
% plainErr = MSE(M,p, iter, @plainSVD)
% shiftErr = MSE(M,p, iter, @shiftSVD)
% unbiasErr = MSE(M, p, iter, @unbiasedSVD)
% witnessErr = MSE(M,p, iter, @witness)
% biasMeanErr = MSE(M, p,iter, @BiasFromMeanExt)
% perUsrAvgErr = MSE(M,p,iter,@PerUserAverageExt)
% userCosErr = MSE(M,p,iter,@UserCosSimExt)
% itemCosErr = MSE(M,p,iter,@ItemCosSimExt)
% SlopeOneErr = MSE_1arg(M,p,iter,@SlopeOne)
% WeightedSlopeOneErr = MSE_1arg(M,p,iter,@WeightedSlopeOne)


%M1 = randObserve(M,0.01);
%WitnessMAE = MAE(M1, @witness)
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
function[Mh] = WeightedSlopeOneExt(X,~,~)
    Mh=WeightedSlopeOne(X);
end