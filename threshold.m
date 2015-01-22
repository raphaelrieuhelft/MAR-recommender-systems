function [ Mh ] = threshold(W, shift)
W(W<shift)=shift;
W(W>1+shift)=1+shift;
Mh=W;

end

