% will need to transform uniform data to gumbel data
n = 1000;
gumbeltransform = @(u) -log(-log(u));
datau = unifrnd(0,1,n,1);
X = gumbeltransform(datau);

% regression
m = @(x) log(1+x.^2);
Y = m(X)+normrnd(0,1,1000,1);

% kernel set up
kn = @(t) normpdf(t);
h1 = 1e-6;
h2 = 1e6;

xline = transpose(-1:0.001:3);

fhat1 = @(x) kernel(kn,h1,x,X);
fhat2 = @(x) kernel(kn,h2,x,X);
mhat1 = @(x) nwregest(kn,h1,X,Y,x);
mhat2 = @(x) nwregest(kn,h2,X,Y,x);

fhat1plot = zeros(length(xline),1);
fhat2plot = zeros(length(xline),1);
mhat1plot = zeros(length(xline),1);
mhat2plot = zeros(length(xline),1);

for i = 1:length(xline)
    fhat1plot(i) = fhat1(xline(i));
    fhat2plot(i) = fhat2(xline(i));
    mhat1plot(i) = mhat1(xline(i));
    mhat2plot(i) = mhat2(xline(i));
end

figure(1); hold on;
title("Kernel density estimate of Gumbel distribution for h=1e-6, h=1e6.");
a1 = plot(xline,fhat1plot); M1 = "h=1e-6";
a2 = plot(xline,fhat2plot); M2 = "h=1e6";
legend([a1,a2],[M1,M2]);
hold off

figure(2); hold on;
title("Kernel regression estimate of Gumbel distribution for h=1e-6, h=1e6.");
b1 = plot(xline,mhat1plot); M12 = "h=1e-6";
b2 = plot(xline,mhat2plot); M22 = "h=1e6";
legend([b1,b2],[M12,M22]);
hold off

%% Part (c).

% reuse previous data.
hs = silverman(datau);
fhatu = @(x) kernel(kn,hs,x,datau);

xuline = transpose(-0.5:0.01:1.5);

fhatline = zeros(length(xuline),1);
fline = zeros(length(xuline),1);

for i = 1:length(xuline)
    fhatline(i) = fhatu(xuline(i));
    fline(i) = (and(xuline(i)>0,xuline(i)<1));
end

figure(3); hold on;
title("Kernel density estimate of standard uniform using standard normal kernel, Silverman bandwidth.")
c1 = plot(xuline,fhatline); M13 = "Kernel density estimate.";
c2 = plot(xuline,fline); M23 = "Standard uniform density.";
legend([c1,c2],[M13,M23]);
hold off;

