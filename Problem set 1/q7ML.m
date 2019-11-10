function objective = q7ML(data,theta)
sizedata = size(data); n=sizedata(1);
lambda=theta(1); beta=theta(2); sigma=theta(3); %sigma rather than sigma squared so that in arguments it definitely is positive

mul = log(lambda)-log(sigma^2/exp(2*log(lambda))+1)/2;
sigmalsquared = log((sigma^2)/exp(2*log(lambda))+1);

mub = log(beta)-log(sigma^2/exp(2*log(beta))+1)/2;
sigmabsquared = log(sigma^2/exp(2*log(beta))+1);

mu = mul+mub;
sigmaasquared = sigmalsquared+sigmabsquared;

objective = 0;
for i=1:n
    objective = objective + log(normpdf(log((log(data(i))-mu)/sqrt(sigmaasquared))))-log(sigmaasquared)/2;
end

objective = real(objective);