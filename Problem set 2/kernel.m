function ret = kernel(k,h,x,X)
% takes a kernel function, bandwidth sequence (or value), point x, and
% data, and produces the kernel estimator

n = length(X);

if (isa(h,'function_handle')==0) %turns constants into function handles so function can take constant bandwidths
    h = @(m) h;
end

kvals = k((x-X)/h(n));
ret = sum(kvals)/(n*h(n));