X=-2:0.02:2;
%y=0
cond0 = q8conditionalpdf(X,0);
cond1 = q8conditionalpdf(X,1);
condm1 = q8conditionalpdf(X,-1);
condhalf = q8conditionalpdf(X,0.5);
condmhalf = q8conditionalpdf(X,-0.5);

figure; hold on
a1 = plot(X,cond0); M1 = "y=0";
a2 = plot(X,cond1); M2 = "y=1";
a3 = plot(X,condm1); M3 = "y=-1";
a4 = plot(X,condhalf); M4 = "y=0.5";
a5 = plot(X,condmhalf); M5 = "y=-0.5";
legend([a1,a2,a3,a4,a5],[M1,M2,M3,M4,M5])
