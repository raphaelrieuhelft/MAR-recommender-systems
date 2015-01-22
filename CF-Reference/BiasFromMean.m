function [ estim ] = BiasFromMean( data )
%BiasFromMean
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[m,n] = size(data);

means = nanmean(data,2);

full_means = repmat(means,1,n);

bias_aux = data - full_means;
bias = nanmean(bias_aux);

estim_all = full_means + repmat(bias,m,1);

estim = data;
nans = isnan(data);
estim(nans) = estim_all(nans);

end
