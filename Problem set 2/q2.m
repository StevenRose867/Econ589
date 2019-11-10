%% Question Two.

%% Part (a). 
% define kernels
k1 = @(t) normpdf(t);
k2 = @(t) normpdf(t).*(3-t.^2)/2;
k3 = @(t) 2.*normpdf(t)-normpdf(t/sqrt(2))/sqrt(2);
k4 = @(t) sin(pi*t)./(pi*t);

% set number of simulations
numsims = 1000;

% will need to transform uniform data to gumbel data
gumbeltransform = @(u) -log(-log(u));

% bandwidths to plot over
h = transpose(0.05:0.01:10);
nset = [10;100;1000];

fhat1k1 = zeros(numsims,length(nset),length(h));
fhat1k2 = zeros(numsims,length(nset),length(h));
fhat1k3 = zeros(numsims,length(nset),length(h));
fhat1k4 = zeros(numsims,length(nset),length(h));

for n=1:length(nset)
    for simulationcount = 1:1000
        dataunif = unifrnd(0,1,nset(n),1);
        data = gumbeltransform(dataunif);
        for i = 1:length(h)
            fhat1k1(simulationcount,n,i) = kernel(k1,h(i),1,data);
            fhat1k2(simulationcount,n,i) = kernel(k2,h(i),1,data);
            fhat1k3(simulationcount,n,i) = kernel(k3,h(i),1,data);
            fhat1k4(simulationcount,n,i) = kernel(k4,h(i),1,data);
        end
    end
    size(data)
end

% just to keep track, fhatkj contains a regression estimate for each
% simulation run given each sample size, for each choice of bandwidth

rmsek1 = zeros(length(h),length(nset));
rmsek2 = zeros(length(h),length(nset));
rmsek3 = zeros(length(h),length(nset));        
rmsek4 = zeros(length(h),length(nset));    

for i = 1:length(h)
    for n = 1:length(nset)
        rmsek1(i,n) = sqrt(sum((fhat1k1(:,n,i)-sum(fhat1k1(:,n,i))/numsims).^2)/numsims);
        rmsek2(i,n) = sqrt(sum((fhat1k2(:,n,i)-sum(fhat1k2(:,n,i))/numsims).^2)/numsims);
        rmsek3(i,n) = sqrt(sum((fhat1k3(:,n,i)-sum(fhat1k3(:,n,i))/numsims).^2)/numsims);
        rmsek4(i,n) = sqrt(sum((fhat1k4(:,n,i)-sum(fhat1k4(:,n,i))/numsims).^2)/numsims);
    end
end

% plot RMSE against h for each sample size, keeping estimators for the same
% sample size on the same graph
for n = 1:length(nset)
    figure(n); hold on
    title("Kernel estimate at 1 RMSE for sample size" + nset(n))
    a1 = plot(h,rmsek1(:,n)); M1="Standard normal";
    a2 = plot(h,rmsek2(:,n)); M2="Standard fourth order";
    a3 = plot(h,rmsek3(:,n)); M3="Twicing";
    a4 = plot(h,rmsek4(:,n)); M4="Infinite order";
    legend([a1,a2,a3,a4],[M1,M2,M3,M4]); 
    hold off
end


