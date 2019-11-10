function ret = q5theta3(data)
%Two step estimator using efficient instrument derived in part two of the
%question. Again, data=[y,x,a]
sizedata=size(data); n=sizedata(1); e = ones(n,1);
theta1 = q5theta1(data);
z=q5z(data(:,2),data(:,3),theta1);

zxbar = dot(z,data(:,2))/n;
zybar = dot(z,data(:,1))/n;
zabar = dot(z,data(:,3))/n;

ret = (-zxbar+sqrt(zxbar*zxbar+4*zybar*zabar))/(2*zabar); %we have chosen the positive root since we know the sample estimates each converge to something non-negative, and we know the true theta is positive.