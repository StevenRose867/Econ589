%cycle through variances, plot RMSE of MLE against variance
n=1000;
lambda0=160; beta0=110;
mvec = size(0.1:0.01:2); m = mvec(1);
RMSEsequence=zeros(m,1);
k=1;
for i=0.1:0.01:2
    i
    mul = log(lambda0)-log(i^2/exp(2*log(lambda0))+1)/2;
    sigmalsquared = log((i^2)/exp(2*log(lambda0))+1);

    mub = log(beta0)-log(i^2/exp(2*log(beta0))+1)/2;
    sigmabsquared = log(i^2/exp(2*log(beta0))+1);

    lengthdata = lognrnd(mul,sqrt(sigmalsquared),[n,1]);
    widthdata = lognrnd(mub,sqrt(sigmabsquared),[n,1]);
    areadata = lengthdata.*widthdata;

    thetahat = q7MLE(areadata);
    RMSEsequence(k) = sqrt(sum((areadata-thetahat(1)*thetahat(2)).^2)/n);
    k=k+1;
end

figure(1)
