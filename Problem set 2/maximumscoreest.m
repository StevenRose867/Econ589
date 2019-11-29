function ret = maximumscoreest(dataX,dataY)

sizedata = size(dataX);
n = sizedata(1); d = sizedata(2);
init = ones(d,1);
objective = @(beta) -msobjective(beta,dataX,dataY);
ret = fminsearch(objective,init);
ret = ret/ret(d);