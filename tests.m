function tests

addpath('CF-Reference')
addpath('SVD')
addpath('SlopeOne')
addpath('ErrorRating')

warning('off','MATLAB:singularMatrix')
warning('off','MATLAB:nearlySingularMatrix')

%%%%%%%

M = load('recommendMatrix.txt');
p=0.2;
iter=3;

nprobas = 4;
probas = linspace(0,1,nprobas+2);
probas = probas(2:nprobas+1);

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
    
    'SlopeOne', @SlopeOneExt;
    'WeightedSlopeOne', @WeightedSlopeOneExt
    };
[nalgos,~] = size(algos);

results = cell(nalgos+1,nprobas+1);
results(1,1) = {'Algorithme  \  p'};
results(2:nalgos+1,1) = algos(:,1);
results(1,2:nprobas+1) = num2cell(probas);
for i = 1:nprobas
    MSEs = cellfun(@(algo) MSE(M,probas(i),iter,algo), algos(:,2));
    MSEs = num2cell(MSEs);
    results(2:nalgos+1,i+1) = MSEs;
end
results


% MSEs = cellfun(@(algo) MSE(M,p,iter,algo), algos(:,2));
% MSEs = num2cell(MSEs);
% 
% % notSVD = logical([1,1,1,1,0,0,0,1,1,1,1]);
% % notSVDalgos = algos(:,2);
% % notSVDalgos = notSVDalgos(notSVD);
% % M1 = randObserve(M,0.1);
% % MAEs = cellfun(@(algo) MAE(M1,algo), notSVDalgos);
% % MAEs = num2cell(MAEs);
% % t1 = cell(nalgos,1);
% % t1(notSVD) = MAEs;
% % MAEs = t1;
% 
% results = [algos(:,1), MSEs, 
%     %MAEs
%     ]
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