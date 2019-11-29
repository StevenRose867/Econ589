function ret = problogL(dataX,dataY,beta)
% objective for probit maximum likelihood
n = length(dataY);
ret = 0;
for i=1:n
    ret = ret + dataY(i)*log(normcdf(dataX(i,:)*beta))+(1-dataY(i))*log(normcdf(-dataX(i,:)*beta));
end
