[X,Y] = meshgrid(-2:.02:2);
pdf = q8jointpdf(X,Y);
surf(X,Y,pdf)