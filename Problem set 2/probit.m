function ret = probit(dataX,dataY)
% probit MLE
sizedata = size(dataX);
n = sizedata(1); d = sizedata(2);
init = ones(d,1);
objective = @(beta) -problogL(dataX,dataY,beta);
ret = fminsearch(objective,init);
ret = ret/ret(d);