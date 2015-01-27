function [ err ] = MAE( data, d, algo, info )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

data = randObserve(data,d);

[r,c] = find(~isnan(data));
cardSu = sum(~isnan(data), 2);
errs = arrayfun(@HideAndGuess,r,c);
err = nansum(errs)/(sum(cardSu)-sum(cardSu==1));


    function err1 = HideAndGuess(u,i)
        assert(not(isnan(data(u,i))))
        data1 = data;
        data1(u,i) = NaN;
        estim = algo(data1, d, info);
        err1 = abs(estim(u,i)-data(u,i)) / cardSu(u);
    end

end

