function [ estim ] = BiasFromMean( data )
%BiasFromMean
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[m,n] = size(data);

means = ones(m,1);
for i=1:m
    u = data(i,:);
    means(i) = mean(u(not(isnan(u))));
end

bias = ones(1,n);
for j=1:n
    obj = data(:,j);
    Sj = not(isnan(obj));
    bias(j) = mean(obj(Sj)-means(Sj));
end

estim_all = repmat(means,1,n) + repmat(bias,m,1);

estim = data;
nans = isnan(data);
estim(nans) = estim(estim_all);

end