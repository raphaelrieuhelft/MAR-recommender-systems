function [ estim ] = BiasFromMean( data )
%BiasFromMean
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);

means = nanmean(data,2);

full_means = repmat(means,1,p);

bias_aux = data - full_means;
bias = nanmean(bias_aux);

estim_all = full_means + repmat(bias,n,1);

estim = data;
nan_pos = isnan(data);
estim(nan_pos) = estim_all(nan_pos);

end
