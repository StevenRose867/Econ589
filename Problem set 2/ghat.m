function ret = ghat(i,X,Y,beta,k)

Xmi = X; Ymi = Y;
Xmi(i,:) = []; %leaving i out
Ymi(i) = [];
sizeXmi = size(Xmi); 
n = sizeXmi(1); 
d = sizeXmi(2); 
 
Xmibeta = Xmi*beta; %input to NW estimator
x = X(i,:)*beta;

h = silverman(Xmibeta);

ret = nwregest(k,h,Xmibeta,Ymi,x);