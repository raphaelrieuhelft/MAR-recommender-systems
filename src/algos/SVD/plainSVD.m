function [ Mh ] = plainSVD( X,p,r )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
X(isnan(X))=0;
W=truncateSVD(X,p,r);
Mh=threshold(W, 0);

end

