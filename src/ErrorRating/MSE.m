function [ errExp ] = MSE(M,proba,iter, algHandle,info)
% info : certains algos appelés savent quoi en faire
[m,n]=size(M);
errSum=0;
for i=1:iter
    X=randObserve(M,proba);
    Mh=algHandle(X,proba,info);
    Mh(Mh>1)=1; Mh(Mh<0)=0;
    diff=M-Mh;
    err=sum(diag(diff'*diff));
    errSum=errSum+err;
end
errExp=(1/(m*n*iter))*errSum;

end

