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

    'PerUserAverage', Ext(@PerUserAverage);
    'BiasFromMean', Ext(@BiasFromMean);
    
    'PlainSVD', @plainSVD;
    'ShiftSVD', @shiftSVD;
    'UnbiasedSVD', @unbiasedSVD;
    
    'UserCosSim', Ext(@userCosSimilarity);
    'ItemCosSim', Ext(@itemCosSimilarity);
    
    'SlopeOne', Ext(@SlopeOne);
    'WeightedSlopeOne', Ext(@WeightedSlopeOne);
    'BiPolarSlopeOne', Ext(@BiPolarSlopeOne);
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


end


function[aalgoExt] = Ext(algo)
    function[Mh] = algoExt(X,~,~)
        Mh=algo(X);
    end
    aalgoExt = @algoExt;
end