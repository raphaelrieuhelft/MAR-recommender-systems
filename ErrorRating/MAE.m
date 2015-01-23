function [ err ] = MAE( data, algo )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[n,~] = size(data);
[r,c] = find(not(isnan(data)));
cardSu = sum(~isnan(data), 2);
errs = arrayfun(@HideAndGuess,r,c);
err = sum(errs)/n;


    function err1 = HideAndGuess(u,i)
        assert(not(isnan(data(u,i))))
        data1 = data;
        data1(u,i) = NaN;
        estim = algo(data1);
        err1 = abs(estim(u,i)-data(u,i)) / cardSu(u);
    end

end

