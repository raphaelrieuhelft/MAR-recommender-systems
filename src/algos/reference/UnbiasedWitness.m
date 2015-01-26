function [ estim ] = UnbiasedWitness( data,p,r )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[unb, b, m]=unbias(data);
unb(isnan(unb)) = 0;
estim=rebias(unb,b,m);

end

