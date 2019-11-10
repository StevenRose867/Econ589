function ret = q3f(u)
ret = 2*normpdf(u);
if u<0
    ret = 0;
end