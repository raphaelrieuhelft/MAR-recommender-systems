function [ Mnorm, b, m ] = unbias( M )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,p]=size(M);
omega=numel(M(isnan(M)==0));
A = zeros(omega, n+p);
c = M(isnan(M)==0);
m=mean(c);
c= c - m;
count=0;
Mnorm = zeros(n,p);
for j=1:p
    for i=1:n
        if (isnan(M(i,j)))
        else
            count=count+1;
            A(count, i)=1;
            A(count, n+j)=1;
        end
    end
end
assert(count==numel(c));
b=(A'*A)\(A'*c);
for j=1:p
    for i=1:n
        if (isnan(M(i,j)))
        else
            Mnorm(i,j)=M(i,j)-(m+b(i)+b(n+j));
        end
    end
end
end

