function ret = averagederivative(dataX,dataY,k,kd,h)
% takes univariate kernel k and build multivariate K as
% K(x,y,z)=k(x)k(y)k(z). kd=k' Bandwidth is your own problem though.

sizedata = size(dataX);
n = sizedata(1); d = sizedata(2);
ret = zeros(d,1);

K = @(x) dcopy(k,d,x);

for i=1:n
    for j=1:n
        gradk = ones(d,1);
        for c = 1:d
            gradk(c) = kd((dataX(i,c)-dataX(j,c))/(2*h))*K((dataX(i,:)-dataX(j,:))/(2*h))/k((dataX(i,c)-dataX(j,c))/(2*h));
        end
        ret = ret + gradk*dataY(i);
    end
end
%ret = -2*ret/((n^2)*h^(d+1)); not sure I see the point of this given we
%normalise anyway
ret = ret/ret(d);