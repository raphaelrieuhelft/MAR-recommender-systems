function [ Mf ] = rebias( Munb, b, m )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[n,p]=size(Munb);
assert(numel(b)==n+p);
bi = repmat(b(1:n), 1, p);
bj = repmat(b(n+1:end), n, 1);
Mf = Munb+bi+bj+m;
end

