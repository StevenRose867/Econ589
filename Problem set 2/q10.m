%% Question 10 (Simulation results)

n = 1000;
Theta = 1:10000;
theta0 = 326; % number of seats needed for a majority in HoC
data = normrnd(theta0,1,n,1);

MLEs = zeros(n,1);
tbars = zeros(n,1);

for i = 1:n
    MLEs(i) = MLEnormd(data(1:i),Theta);
    tbars(i) = sum(data(1:i))/i;
end

figure(1); hold on
title("Plot of MLE and sample average against number of observations.")
a110 = plot(1:n,MLEs); M110 = "MLE";
a210 = plot(1:n,tbars); M210 = "Sample average.";
legend([a110,a210],[M110,M210])
hold off