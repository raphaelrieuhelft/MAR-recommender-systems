function [ W ] = truncateSVD( X,p,r )
[m n]=size(X);
[U,S,V]=svd(X, 'econ');

S((r+1):end, :)=0;
W=(1/p)*U*S*(V(:, 1:m))';



end

