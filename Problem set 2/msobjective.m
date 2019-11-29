function ret = msobjective(beta,dataX,dataY)

ret = 0;
indicator = 0;
for i = 1:length(dataY)
    if dataX(i,:)*beta>0
        indicator = 1;
    end
    ret = ret + (dataY(i)-0.5)*indicator;
    indicator = 0;
end
