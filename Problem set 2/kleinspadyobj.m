function ret = kleinspadyobj(dataX,dataY,beta,k)

sizedata = size(dataX);
n=sizedata(1); d=sizedata(2);

ret = 0;
for i = 1:n
    ret = ret + dataY(i)*log(ghat(i,dataX,dataY,beta,k))+(1-dataY(i))*(1-log(ghat(i,dataX,dataY,beta,k)));
end