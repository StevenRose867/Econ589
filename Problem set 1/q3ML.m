function ret = q3ML(data,theta,f)
ret = 0;
sizedata = size(data); n=sizedata(1);
for i=1:n
    ret = ret+log(f(exp(data(i)-theta)));
end