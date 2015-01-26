function [ estim ] = BiPolarSlopeOne( data, dev, c )
%BiPolarSlopeOne
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[n,p] = size(data);

mean = nanmean(data,2);
means = repmat(mean,1,p);

not_like_pos = data <= means;
data_like = data;
data_like(not_like_pos) = NaN;

not_dislike_pos = data >= means;
data_dislike = data;
data_dislike(not_dislike_pos) = NaN;

[dev_like,c_like] = Dev(data_like);
dev_like(isnan(dev_like)) = 0;
c_like(isnan(c_like)) = 0;

[dev_dislike,c_dislike] = Dev(data_dislike);
dev_dislike(isnan(dev_dislike)) = 0;
c_dislike(isnan(c_dislike)) = 0;

like_pos_double = double(data > means);
t1_like = like_pos_double*(dev_like.*c_like)';
data_like(isnan(data_like)) = 0;
t2_like = data_like*c_like'; 
t3_like = like_pos_double*c_like';

dislike_pos_double = double(data < means);
t1_dislike = dislike_pos_double*(dev_dislike.*c_dislike)';
data_dislike(isnan(data_dislike)) = 0;
t2_dislike = data_dislike*c_dislike'; 
t3_dislike = dislike_pos_double*c_dislike';

estim_all = (t1_like + t2_like + t1_dislike + t2_dislike)...
    ./ (t3_like + t3_dislike);

estim = data;
nan_pos = isnan(data);
estim(nan_pos) = estim_all(nan_pos);

end

