function [ err ] = MAE( data, d, algo, info )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

num_questions = 100;
proba_question = num_questions/(d*numel(data));

data = randObserve(data,d);

[row,col] = find(~isnan(data));
questions = rand(numel(row),1)<proba_question;
row = row(questions); col = col(questions);

cardSu = sum(~isnan(data), 2);
errs = arrayfun(@HideAndGuess,row,col);
err = nansum(errs)/(sum(cardSu)-sum(cardSu==1));


    function err1 = HideAndGuess(u,i)
        assert(not(isnan(data(u,i))))
        data1 = data;
        data1(u,i) = NaN;
        estim = algo(data1, d, info);
        err1 = abs(estim(u,i)-data(u,i)) / cardSu(u);
    end

end

