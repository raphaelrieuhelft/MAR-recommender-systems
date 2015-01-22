jester = csvread('jester-data-1.csv');
jester(jester==99)=NaN;
jester=jester/10;