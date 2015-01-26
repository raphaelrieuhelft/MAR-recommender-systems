function [R,g] = readjester()
    jester = csvread('jesterfinal151cols.csv');
    jester(jester==99)=NaN;
    R=jester/10;
    R=R(1:5000, :);
    g=[2 3 4 5 6 7 8 9];
end