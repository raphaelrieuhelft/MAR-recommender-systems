function [ estim ] = PerUserAverage( data )
%PerUserAverage P(u) = mean(u)
%   See http://arxiv.org/pdf/cs/0702144v2.pdf

[m,~] = size(data);
estim = data;

for i=1:m
    u = data(i,:);
    umean = mean(u(not(isnan(u))));
    nans = numel(u(isnan(u)));
    u(isnan(u)) = umean*ones(1,nans);
    estim(i,:) = u;
end

end