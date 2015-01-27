function [ W ] = truncateSVD( X,p,r )
[m n]=size(X);
k = min(m,n);
[U,S,V]=svd(X, 'econ');

S((r+1):end, :)=0;
W=(1/p)*U*S*(V(:, 1:k))';



end

