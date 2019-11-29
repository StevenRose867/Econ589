function ret = dcopy(k,d,X)

ret = 1;
for i = 1:d
    ret = ret*k(X(i));
end