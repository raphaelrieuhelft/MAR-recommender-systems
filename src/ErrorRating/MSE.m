function [ errExp ] = MSE(M,proba,iter, algHandle,r)

[m,n]=size(M);
errSum=0;
for i=1:iter
    X=randObserve(M,proba);
    Mh=algHandle(X,proba,r);
    diff=M-Mh;
    err=sum(diag(diff'*diff));
    errSum=errSum+err;
end
errExp=(1/(m*n*iter))*errSum;

end

