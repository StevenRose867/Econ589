data = readmatrix('ss10hsc.csv','range','BA2:BA22796'); %household income data

% need to clean up the data
nanpoints = isnan(data);
data(nanpoints) = [];
missingentries = sum(nanpoints); %number of entries that are missing

n = length(data);
assert(any(isnan(data))==0,'The data has not been cleaned up successfully.')
%incomes = array2table(data);
%writetable(incomes,'incomes.csv')

datatest = data(1:10);
kn = @(x) normpdf(x);
obj = @(h) cvobj(h,kn,datatest);
H = 1:20;
fvals = zeros(size(H));
for counter=1:20
    fvals(counter) = obj(H(counter));
end
