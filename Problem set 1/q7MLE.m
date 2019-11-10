function bestthetahat = q7MLE(data)
sizedata = size(data); n = sizedata(1);
Qhat = @(theta) -q7ML(data,theta);
areamean = sum(data)/n;

bestthetahat=ones(3,1); thetahat=zeros(3,1);

options = optimset('TolFun',1e-10);
for i=10:50:1000
    for j=1:50:1000
        thetahat = fminsearch(Qhat,[i,areamean/i,j]);
        if Qhat(thetahat)<Qhat(bestthetahat)
            bestthetahat=thetahat;
        end
    end
end
bestthetahat=abs(bestthetahat); %sigma only appears as sigma^2 so may come back negative


    