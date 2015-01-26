function [ u ] = eigentasteProjection( R, gaugeIndices )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(R);
k=numel(gaugeIndices);
Rg = R(:, gaugeIndices);
mu = mean(Rg);
Rgm = Rg-repmat(mu, n, 1);
sig = diag(cov(Rgm));
A = Rgm./repmat(sig', n, 1);

C=(1/(n-1))*(A'*A);

[E,~]=eig(C); %E*D*E'=C

u=A*(E(:, 1:2));

end

