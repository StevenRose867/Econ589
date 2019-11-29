function ret = nwregest(k,h,X,Y,x)

if (isa(h,'function_handle')==0) %turns constants into function handles so function can take constant bandwidths
    h = @(m) h;
end

assert(isequal(size(X),size(Y)),'Data does not match in size.')
n = length(X);

kvals = zeros(n,1);
for i = 1:n
    kvals(i) = k((x-X(i))/h(n));
end
ret = sum(kvals.*Y)/sum(kvals);