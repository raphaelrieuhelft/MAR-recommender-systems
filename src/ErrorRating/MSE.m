function [ errExp ] = MSE(M,p,iter, algHandle)
%M=M+shift;
[m,n]=size(M);
r=rank(M);
errSum=0;
for i=1:iter
    X=randObserve(M,p);
    %W=truncateSVD(X,p,r);
    %Mh=threshold(W, shift);
    Mh=algHandle(X,p,r);
    diff=M-Mh;
    err=sum(diag(diff'*diff));
    errSum=errSum+err;
end
errExp=(1/(m*n*iter))*errSum;

end

