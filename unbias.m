function [ Mnorm, b, m ] = unbias( M )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,p]=size(M);
c = M(~isnan(M));
m=mean(c);
c= c - m;

[i,j,s] = find(~isnan(M));
k = 1:numel(i);

A1 = sparse(k,i,s);
A2 = sparse(k,j,s);
A = double([A1,A2]);

b=(A'*A)\(A'*c);

Mnorm = M - ( m + repmat(b(1:n),1,p) + repmat(b(n+1:n+p)',n,1) );
Mnorm(isnan(Mnorm)) = 0;

end

