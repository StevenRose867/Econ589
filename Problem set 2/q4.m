%% Question Four.

kn = @(x) normpdf(x); %normal kernel
data = readmatrix('ss10hsc.csv','range','BA2:BA22796'); %household income data

% need to clean up the data. Did this earlier to pass the data to the c++
% file but it's not exactly a rate limiting factor here
nanpoints = isnan(data);
data(nanpoints) = [];
missingentries = sum(nanpoints); %number of entries that are missing

n = length(data);
assert(any(isnan(data))==0,'The data has not been cleaned up successfully.')

ha = silverman(data);
hb = 1059.4656; %comes from some c++ code in the folder "cvkernel", or the file "main"
ka = @(x) kernel(kn,ha,x,data);
kb = @(x) kernel(kn,hb,x,data);

X = 0:100:100000;
kaplot = ka(X); kbplot = kb(X);
figure(1)
hold on
title("Cross validation.")
a2 = plot(X,kbplot);
