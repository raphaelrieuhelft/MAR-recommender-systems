function [ Mh ] = userCosSimilarity( X )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
[Munb, b ,m]=unbias(X);
normL = sqrt(sum(Munb .^ 2, 2));
normR = sqrt(sum(Munb' .^ 2, 1));
coses = bsxfun(@rdivide, bsxfun(@rdivide,Munb*Munb', normL), normR);
sums = sum(abs(coses), 2);
coses = bsxfun(@rdivide, coses, sums);
Mest = coses*Munb;
Mh=rebias(Mest, b, m);

end

