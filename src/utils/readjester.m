function [R,g,g_comp] = readjester()
    jester = csvread('data/jesterfinal151cols.csv');
    jester(jester==99)=NaN;
    R=jester/20+.5;
    n=5000;
    R=R(1:5000, :);
    [~,p]=size(R);
    g=[2 3 4 5 6 7 8 9];
    g_comp = [1 10:p];
end