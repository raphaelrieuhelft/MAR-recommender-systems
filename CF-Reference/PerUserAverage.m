function [ estim ] = PerUserAverage( data )
%PerUserAverage P(u) = mean(u)
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[~,n] = size(data);

means = nanmean(data,2);
estim_all = repmat(means,1,n);
estim = data;
nans = isnan(data);
estim(nans) = estim_all(nans);

end
