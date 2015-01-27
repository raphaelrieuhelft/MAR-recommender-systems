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
    
    %'PlainSVD', @plainSVD, 0;
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



Results_MSE = [names ...
    MSEsBonus(.05) MSEsJester(.05) ...
    MSEsBonus(.2) MSEsJester(.2) ...
    MSEsBonus(.5)
    ]



%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
%%% eigentaste %%%
%%%%%%%%%%%%%%%%%%

%%% courbes permettant de déterminer maxClust optimal pour p=.2 et p=.1
% maxClust = 50:50:1000;
% errs = arrayfun(@(m) MSE_forJester(Jh,J,.2,iter,@eigentaste,m),maxClust);
% plot(maxClust,errs);
% maxClust = 5:5:100;
% errs = arrayfun(@(m) MSE_forJester(Jh,J,.1,iter,@eigentaste,m),maxClust);
% plot(maxClust,errs);

eigentest_Jester = { 'p=0.1', 'p=0.2'; ...
    MSE_forJester(Jh,J,.1,iter,@eigentaste,20), ...
    MSE_forJester(Jh,J,.2,iter,@eigentaste,600)
    }


%%%%%%%%%%%%%%%

%%%%%%%%%%%
%%% MAE %%%
%%%%%%%%%%%

    function results = MAEs(d) % d: densité des coefficients non NaN
        results = cell(nalgos+1,1);
        results(1) = {strcat('d=',num2str(d))};
        v = cellfun(@(algo) MAE(M,d,algo,default_rank),...
            algos(:,2));
        results(2:nalgos+1) = num2cell(v);
    end

%Results_MAE = [names MAEs(.001)]
%   abandonné car pour d grande c'est trop long 
%   et pour d petite on a des erreurs égales à 0
%   car il y a trop peu de coefficients

end


function[aalgoExt] = Ext(algo)
    function[Mh] = algoExt(X,~,~)
        Mh=algo(X);
    end
    aalgoExt = @algoExt;
end