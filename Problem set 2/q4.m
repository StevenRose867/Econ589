%% Question Four.

kn = @(x) normpdf(x); %normal kernel
data = readmatrix('ss10hsc.csv','range','BA2:BA22796'); %household income data

% need to clean up the data
nanpoints = isnan(data);
data(nanpoints) = [];
missingentries = sum(nanpoints); %number of entries that are missing

n = length(data);
assert(any(isnan(data))==0,'The data has not been cleaned up successfully.')

ha = silverman(data);
ka = @(x) kernel(kn,ha,x,data);
hb = crossvalidation(kn,data);
kb = @(x) kernel(kn,hb,x,data);

X = 0:100:100000;
kaplot = ka(X); kbplot = kb(X);
figure(1)
hold on
a1 = plot(X,kaplot); M1 = 'Silvermans rule';
a2 = plot(X,kbplot); M2 = 'Cross validation';
legend([a1,a2],[M1,M2])