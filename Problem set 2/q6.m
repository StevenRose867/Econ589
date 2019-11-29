%% Question 6.
%% Set up.
n = [100;1000];
beta0 = [-16;-8.8;1.87;18.3;1]; %needed some beta0, drew it randomly from unif(-20,20)

% choose the first two regressors to be discrete, last three to be
% continuous
% first component poisson, 2nd unif({-10,-9,...,9,10}), 3rd exponential,
% 4th unif(-10,10), 5th normal
% only need to draw these 1000 times then can reuse

% create our individuals
X = zeros(n(2),5);
X(:,1) = poissrnd(3,n(2),1);
X(:,2) = unidrnd(20,n(2),1)-10;
X(:,3) = exprnd(3,n(2),1);
X(:,4) = unifrnd(-10,10,n(2),1);
X(:,5) = normrnd(0,1,n(2),1);

% need to create function to create heteroscedastic errors
errorsd = @(x) exp(x(5));

% G determined in other file, G.m

% kernel and derivative
kn = @(x) normpdf(x);
kd = @(x) -x*normpdf(x);

ks = zeros(5,8);
p = zeros(5,8);
ms = zeros(5,8);
ade = zeros(5,8);

%% Experiments.
%% Experiment 1, normal, homo, 100
% create data
errors1 = normrnd(0,1,n(1),1);
latent1 = X(1:n(1),:)*beta0+errors1;
Y1 = G(latent1);

% use estimators
ks(:,1) = kleinspady(X(1:n(1),:),Y1,kn)
p(:,1) = probit(X(1:n(1),:),Y1)
ms(:,1) = maximumscoreest(X(1:n(1),:),Y1)

% need bandwidth for average derivative, will use the silverman bandwidth
% for X*ks1
h1 = silverman(X(1:n(1),:)*ks(:,1));
ade(:,1) = averagederivative(X(1:n(1),:),Y1,kn,kd,h1)



% need bandwidth, life is short, 

%% Experiment 2, normal, homo, 1000
% create data
errors2 = normrnd(0,1,n(2),1);
latent2 = X(1:n(2),:)*beta0+errors2;
Y2 = G(latent2);

ks(:,2) = kleinspady(X(1:n(2),:),Y2,kn)
p(:,2) = probit(X(1:n(2),:),Y2)
ms(:,2) = maximumscoreest(X,Y2)

h2 = silverman(X(1:n(2),:)*ks(:,2));
ade(:,2) = averagederivative(X(1:n(2),:),Y2,kn,kd,h2)
%% Exeriment 3, not normal, homo, 100
% will use a bimodal distribution
% create data
errors3 = bimodalnormrnd(n(1),1);
latent3 = X(1:n(1),:)*beta0+errors3;
Y3 = G(latent3);

p(:,3) = probit(X(1:n(1),:),Y3)
ks(:,3) = kleinspady(X(1:n(1),:),Y3,kn)
ms(:,3) = maximumscoreest(X(1:n(1),:),Y3)

h3 = silverman(X(1:n(1),:)*ks(:,3));
ade(:,3) = averagederivative(X(1:n(1),:),Y3,kn,kd,h3)
%% Experiment 4, not normal, homo 1000
errors4 = bimodalnormrnd(n(2),1);
latent4 = X(1:n(2),:)*beta0+errors4;
Y4 = G(latent4);

ks(:,4) = kleinspady(X(1:n(2),:),Y4,kn)
p(:,4) = probit(X(1:n(2),:),Y4)
ms(:,4) = maximumscoreest(X,Y4)

h4 = silverman(X(1:n(2),:)*ks(:,4));
ade(:,4) = averagederivative(X(1:n(2),:),Y4,kn,kd,h4)
%% Experiment 5, normal, hetero, 100
errors5 = normrnd(0,errorsd(X(1:n(1),:)),n(1),1);
latent5 = X(1:n(1),:)*beta0+errors5;
Y5 = G(latent5);

ks(:,5) = kleinspady(X(1:n(1),:),Y5,kn)
p(:,5) = probit(X(1:n(1),:),Y5)
ms(:,5) = maximumscoreest(X(1:n(1),:),Y5)

h5 = silverman(X(1:n(1),:)*ks(:,5));
ade(:,5) = averagederivative(X(1:n(1),:),Y5,kn,kd,h5)
%% Experiment 6, normal, hetero, 1000
errors6 = normrnd(0,errorsd(X(1:n(2),:)),n(2),1);
latent6 = X(1:n(2),:)*beta0+errors6;
Y6 = G(latent6);

ks(:,6) = kleinspady(X(1:n(2),:),Y6,kn)
p(:,6) = probit(X(1:n(2),:),Y6)
ms(:,6) = maximumscoreest(X,Y6)

h6 = silverman(X(1:n(2),:)*ks(:,6));
ade(:,6) = averagederivative(X(1:n(2),:),Y6,kn,kd,h6)
%% Experiment 7, not normal, hetero, 100
errors7 = bimodalnormrnd(n(1),errorsd(X(1:n(1),:)));
latent7 = X(1:n(1),:)*beta0+errors7;
Y7 = G(latent7);

ks(:,7) = kleinspady(X(1:n(1),:),Y7,kn)
p(:,7) = probit(X(1:n(1),:),Y7)
ms(:,7) = maximumscoreest(X(1:n(1),:),Y7)

h7 = silverman(X(1:n(1),:)*ks(:,7));
ade(:,7) = averagederivative(X(1:n(1),:),Y7,kn,kd,h7)
%% Experiment 8, not normal, hetero, 1000
% create data
errors8 = bimodalnormrnd(n(2),errorsd(X(1:n(2),:)));
latent8 = X(1:n(2),:)*beta0+errors8;
Y8 = G(latent8);

ks(:,8) = kleinspady(X(1:n(2),:),Y8,kn)
p(:,8) = probit(X(1:n(2),:),Y8)
ms(:,8) = maximumscoreest(X,Y8)

h8 = silverman(X(1:n(2),:)*ks(:,8));
ade(:,8) = averagederivative(X(1:n(2),:),Y8,kn,kd,h8)

%% Summary
ksdistances = ks-beta0;
pdistances = p-beta0;
msdistances = ms-beta0;
adedistances = ade-beta0;

kserrors = zeros(8,1);
perrors = zeros(8,1);
mserrors = zeros(8,1);
adeerrors = zeros(8,1);
for i = 1:8
    kserrors(i) = sqrt(sum(ksdistances(:,i).^2));
    perrors(i) = sqrt(sum(pdistances(:,i).^2));
    mserrors(i) = sqrt(sum(msdistances(:,i).^2));
    adeerrors(i) = sqrt(sum(adedistances(:,i).^2));
end

errors = [kserrors,perrors,mserrors,adeerrors];