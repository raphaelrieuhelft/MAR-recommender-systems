function [ estim ] = SlopeOne( data )
%SlopeOne
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);

[dev,~] = Dev(data);

mean_devij_for_j_in_Ri = nanmean(dev,2);

means = nanmean(data,2);


estim_all = repmat(means,1,p) + repmat(mean_devij_for_j_in_Ri',n,1);

estim = data;
nan_pos = isnan(data);
estim(nan_pos) = estim_all(nan_pos);

end

