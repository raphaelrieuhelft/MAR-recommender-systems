function [ Mh ] = eigentaste( R, p, maxClust )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

gaugeIndices = 1:8;

[n,m]=size(R);
k=numel(gaugeIndices);
Rg = R(:, gaugeIndices);
mu = mean(Rg);
Rgm = Rg-repmat(mu, n, 1);
sig = diag(cov(Rgm));
A = Rgm./repmat(sig', n, 1);

C=(1/(n-1))*(A'*A);

[E,~]=eigs(C,2); %E*D*E'=C

U=A*E;
Z=linkage(U,'ward', 'euclidean');
T=cluster(Z, 'maxclust', maxClust);
d0=R;
d0(isnan(R))=0;
sameClust = (repmat(T,1,n)==repmat(T',n,1));
sums = sameClust*d0;
counts = sameClust*double(~isnan(R));
Mh = sums ./ counts;
Mh(isnan(Mh))=0;
end

