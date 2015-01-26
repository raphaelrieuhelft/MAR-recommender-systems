function [ X ] = randObserve(M,p)
[m,n]=size(M);
rolls=rand(m,n);
X=M;
X(rolls>=p)=NaN;
end

