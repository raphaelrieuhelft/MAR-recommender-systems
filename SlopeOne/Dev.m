function [ dev, c ] = Dev( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[n,p] = size(data);

nan_pos = isnan(data);
notnan_pos_double = ones(n,p) - double(nan_pos);

data_with_zeros = data;
data_with_zeros(nan_pos) = 0;

sum_ui_for_u_in_Sj = data_with_zeros'*notnan_pos_double;
sum_uj_for_u_in_Si = notnan_pos_double'*data_with_zeros;

card_Si_inter_Sj = (notnan_pos_double')*notnan_pos_double;
card_Si_inter_Sj(logical(eye(p))) = NaN;

dev = (sum_ui_for_u_in_Sj - sum_uj_for_u_in_Si) ./ card_Si_inter_Sj;

c = card_Si_inter_Sj;

end

