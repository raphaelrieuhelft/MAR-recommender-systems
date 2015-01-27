function [ errExp ] = MSE_forJester( Mhelp,M, proba, iter, algHandle,info )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

num_not_nan = sum(sum(~isnan(M)));
density = num_not_nan/numel(M);
assert(proba<=density);
proba1=proba/density;

[~,g]=size(Mhelp);
[m,n]=size(M);

errSum=0;
for i=1:iter
    X=[Mhelp, randObserve(M,proba1)];
    Mh=algHandle(X,proba,info);
    diff=M-Mh(:,g+1:end);
    diff2 = diff.^2;
    err = sum(nansum(diff2));
    errSum=errSum+err;
end
errExp=(1/(num_not_nan*iter))*errSum;

end

