function ret = kleinspady(dataX,dataY,k)

sizedata = size(dataX);
d = sizedata(2);
init = ones(d,1);
objective = @(beta) -kleinspadyobj(dataX,dataY,beta,k);
ret = fminsearch(objective,init);
ret = ret/ret(d);