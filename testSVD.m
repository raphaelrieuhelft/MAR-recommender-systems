M = load('recommendMatrix.txt');
plainErr = MSE(M,0.2, 1, @plainSVD)
shiftErr = MSE(M,0.2, 1, @shiftSVD)
unbiasErr = MSE(M, 0.2, 1, @unbiasedSVD)
