function ret = silverman(X)
% returns the bandwidth using silverman's rule of thumb for kernel k and
% data X.
n = length(X);
samplevar = sqrt(sum((X-sum(X)/n).^2)/(n-1));
ret = samplevar*n^(-0.2);