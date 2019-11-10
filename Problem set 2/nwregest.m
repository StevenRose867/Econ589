function ret = nwregest(k,h,X,Y,x)

if (isa(h,'function_handle')==0) %turns constants into function handles so function can take constant bandwidths
    h = @(m) h;
end

assert(size(X)==size(Y),'Data does not match in size.')
n = length(X);

kvals = k((x-X)/h(n));
ret = sum(kvals.*Y)/sum(kvals);