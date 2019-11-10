[X,Y] = meshgrid(-3:.03:3);
pdf = q8fjointpdf(X,Y);
surf(X,Y,pdf)