function [thetahatall,data] = q3fixedtheta(theta0,n)
%%creates a data set of n points using question 3's data generation
%%process, creates estimator for first k points for k=1,...,n to check rate
%%of convergence.

%create the data
u = abs(normrnd(0,1,n,1));
y = theta0+log(u);
data=[u,y];
%create vector of the MLE estimators for first k observations where
%k=1,...,n
thetahatall = zeros(n,1);
for i = 1:n
    thetahatall(i) = q3MLE(y(1:i));
end