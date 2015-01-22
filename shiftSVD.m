function [ Mh ] = shiftSVD( X,p,r )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
X=X-0.5;
X(isnan(X))=0;
W=truncateSVD(X,p,r);
Mest=threshold(W, -0.5);
Mh = Mest+0.5;
end

