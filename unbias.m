function [ Mnorm, b, m ] = unbias( M )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,p]=size(M);
omega=numel(M(isnan(M)==0));
A = zeros(omega, n+p);
c = M(~isnan(M));
m=mean(c);
c= c - m;

[row,col] = find(~isnan(M));
count = numel(row);
ignore = arrayfun(@FillA,row,col,(1:count)');
    function output = FillA(i,j,k)
        assert(not(isnan(M(i,j))))
        A(k, i)=1;
        A(k, n+j)=1;
        output = 0;
    end

b=(A'*A)\(A'*c);

Mnorm = M - ( m + repmat(b(1:n),1,p) + repmat(b(n+1:n+p)',n,1) );
Mnorm(isnan(Mnorm)) = 0;

end

