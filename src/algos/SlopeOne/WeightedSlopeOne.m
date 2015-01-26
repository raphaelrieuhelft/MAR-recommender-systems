function [ estim ] = WeightedSlopeOne( data )
%WeightedSlopeOne
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);

nan_pos = isnan(data);
notnan_pos_double = ones(n,p) - double(nan_pos);
data_zeros = data; data_zeros(nan_pos) = 0;

[dev,c] = Dev(data);
dev(isnan(dev)) = 0;
c(isnan(c)) = 0;

t1 = notnan_pos_double*(dev.*c)';
t2 = data_zeros*c';
t3 = notnan_pos_double*c';
estim_all = (t1 + t2) ./ t3;

estim = data;
estim(nan_pos) = estim_all(nan_pos);

end

