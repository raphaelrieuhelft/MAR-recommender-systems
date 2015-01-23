function [ estim ] = SlopeOne( data )
%SlopeOne
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);

nan_pos = isnan(data);
nan_pos_double = double(nan_pos);

data_with_zeros = data;
data_with_zeros(nan_pos) = 0;

sum_ui_for_u_in_Sj = data_with_zeros'*nan_pos_double;
sum_uj_for_u_in_Si = nan_pos_double'*data_with_zeros;

num_Si_inter_Sj = (nan_pos_double')*nan_pos_double;

dev = (sum_ui_for_u_in_Sj - sum_uj_for_u_in_Si) ./ num_Si_inter_Sj;


mean_devij_for_j_in_Ri = nanmean(dev,2);

means = nanmean(data,2);


estim_all = repmat(means,1,p) + repmat(mean_devij_for_j_in_Ri',n,1);

estim = data;
estim(nan_pos) = estim_all(nan_pos);

end

