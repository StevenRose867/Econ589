function thetahat = q3MLE(data)
%Question 3 - generate data, run likelihood estimator
objective = @(theta) -q3ML(data,theta,@q3f);
thetahat = fminbnd(objective,-100000,100000);