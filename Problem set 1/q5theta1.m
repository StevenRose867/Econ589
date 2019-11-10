function ret = q5theta1(data)
%data is expected to be an n by 3 matrix [y,x,a] where
%y=theta0*x+theta0^2*a+u, a, x and y are n by 1. theta1 estimates the estimator by solving the
%moment condition using Gamma=(x,a)'.
sizedata = size(data); n=sizedata(1); e=ones(n,1); %e will be useful for calculating sample averages

aybar = dot(data(:,3),data(:,1))/n;
axbar = dot(data(:,3),data(:,2))/n;
a2bar = dot(data(:,3),data(:,3))/n;
xybar = dot(data(:,2),data(:,1))/n;
x2bar = dot(data(:,2),data(:,2))/n;

ret = (aybar*axbar-a2bar*xybar)/(axbar*axbar-a2bar*x2bar);