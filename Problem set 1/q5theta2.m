function ret = q5theta2(data)
%data is expected to be an n by 3 matrix [y,x,a] where
%y=theta0*x+theta0^2*a+u, a, x and y are n by 1.
sizedata=size(data); n=sizedata(1); 

xybar = dot(data(:,2),data(:,1))/n;
theta1coefficient = (2*dot(data(:,3),data(:,1))-dot(data(:,2),data(:,2)))/n;
theta2coefficient = -3*dot(data(:,3),data(:,2))/n;
theta3coefficient = -2*dot(data(:,3),data(:,3))/n;

p = [theta3coefficient theta2coefficient theta1coefficient xybar];
cand = roots(p);
ret = max(cand);

