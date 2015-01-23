function [ estim ] = SlopeOne( data )
%SlopeOne
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);





means = nanmean(data,2);

full_means = repmat(means,1,p);





bias_aux = data - full_means;
bias = nanmean(bias_aux);

estim_all = full_means + repmat(bias,n,1);

estim = data;
nans = isnan(data);
estim(nans) = estim_all(nans);


end

