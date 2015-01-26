function [ Mh ] = witness( X,p,r )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
X(isnan(X))=0.5;
Mh=X;
end

