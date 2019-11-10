function fxy=q8jointpdf(x,y)

%define these variables so that we don't have to repeatedly calculate them
phix = normpdf(x); phiy = normpdf(y); phimx = normpdf(-x); phimy = normpdf(-y);
Phix = normcdf(x); Phiy = normcdf(y); Phimx = normcdf(-x); Phimy = normcdf(-y);

fxy = phix.*phiy.*(1-0.5.*Phimx.*Phimy)+0.5.*phix.*phimy.*Phimx.*Phiy+0.5.*Phix.*phiy.*phimx.*Phimy-0.5.*phimx.*phimy.*Phix.*Phiy;
