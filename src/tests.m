function tests

addpath('utils')
addpath('ErrorRating')
addpath('algos')
addpath('algos/reference')
addpath('algos/SVD')
addpath('algos/SlopeOne')

warning('off','MATLAB:singularMatrix')
warning('off','MATLAB:nearlySingularMatrix')

%%%%%%%

p=0.2;
iter=1;
default_rank=10;

M = load('data/recommendMatrix.txt');
rankM = rank(M);

[Jester,g,g_comp] = readjester();
Jh = Jester(:,g);
J = Jester(:,g_comp);

nprobas = 4;
probas = linspace(0,1,nprobas+2);
probas = probas(2:nprobas+1);

algos = {
    'Witness', @witness, 1;
    'UnbiasedWitness', @UnbiasedWitness, 1;

    'PerUserAverage', Ext(@PerUserAverage), 1;
    'BiasFromMean', Ext(@BiasFromMean), 1;
    
    'PlainSVD', @plainSVD, 0;
    'ShiftSVD', @shiftSVD, 0;
    'UnbiasedSVD', @unbiasedSVD, 0;
    
    'UserCosSim', Ext(@userCosSimilarity), 1;
    'ItemCosSim', Ext(@itemCosSimilarity), 1;
    
    'SlopeOne', Ext(@SlopeOne), 1;
    'WeightedSlopeOne', Ext(@WeightedSlopeOne), 1;
    'BiPolarSlopeOne', Ext(@BiPolarSlopeOne), 0;
    };
[nalgos,~] = size(algos);

names = cell(nalgos+1,1);
names(1) = {'Algorithme'};
names(2:nalgos+1) = algos(:,1);

% notSVD = logical(cell2mat(algos(:,3)));
% notSVDalgos = algos(:,2); notSVDalgos = notSVDalgos(notSVD);

    function results = MSEsBonus(p)
        results = cell(nalgos+1,1);
        results(1) = {strcat('bonus, p=',num2str(p))};
        v = cellfun(@(algo) MSE(M,p,iter,algo,rankM), algos(:,2));
        results(2:nalgos+1) = num2cell(v);
    end

    function results = MSEsJester(p)
        results = cell(nalgos+1,1);
        results(1) = {strcat('Jester, p=',num2str(p))};
        v = cellfun(@(algo) MSE_forJester(Jh,J,p,iter,algo,default_rank),...
            algos(:,2));
        results(2:nalgos+1) = num2cell(v);
    end

results = [names ...
    MSEsBonus(.05) MSEsJester(.05) ...
    MSEsBonus(.2) MSEsJester(.2) ...
    MSEsBonus(.5)
    ]


res = { 'Eigentaste', 'Jester, p=0.2', ...
    MSE_forJester(Jh,J,.2,iter,@eigentaste,0) }


% results = cell(nalgos+1,nprobas+1);
% results(1,1) = {'Algorithme  \  p'};
% results(2:nalgos+1,1) = algos(:,1);
% results(1,2:nprobas+1) = num2cell(probas);
% for i = 1:nprobas
%     MSEs = cellfun(@(algo) MSE(M,probas(i),iter,algo), algos(:,2));
%     MSEs = num2cell(MSEs);
%     results(2:nalgos+1,i+1) = MSEs;
% end
% results


% doMAE = logical(cell2mat(algos(:,3)));
% doMAEalgos = algos(:,2);
% doMAEalgos = doMAEalgos(doMAE);
% M1 = randObserve(M,0.01);
% MAEs_vect = cellfun(@(algo) MAE(M1,algo), doMAEalgos);
% %MAEs_vect = ones(numel(notSVDalgos),1);
% MAEs_cell = num2cell(MAEs_vect);
% MAEs = cell(nalgos,1);
% %MAEs(1) = {'MAE'};
% MAEs(doMAE) = MAEs_cell;
% 
% results = [results, [{'MAE'};MAEs]]


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