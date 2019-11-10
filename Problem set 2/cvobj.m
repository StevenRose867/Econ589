function ret = cvobj(h,k,X)
% objective for leave-one-out cross validation

n=length(X);
ret = 0;

for i=1:n
    logarg = 0;
    for j=1:n
        if j==i
            continue
        end
        logarg = logarg+k((X(j)-X(i))/h);
    end
    logarg = logarg - k(0); %get rid of the case where i=j
    logarg = logarg/((n-1)*h);
    ret = ret+log(logarg);
end
