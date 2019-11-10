%first generate data
n=10000;
errorvariance = 0.5;
theta0=1;

dataset = zeros(n,3);
for i = 1:n
    dataset(i,2:3) = mvnrnd([0,0],[1 0.5;0.5 1]);
    dataset(i,1) = dataset(i,2)*theta0 + dataset(i,3)*theta0^2 + normrnd(0,errorvariance);
end

theta1sequence = zeros(n,1); theta2sequence = zeros(n,1); theta3sequence = zeros(n,1);

for i=1:n
    theta1sequence(i)=q5theta1(dataset(1:i,:));
    theta2sequence(i)=q5theta2(dataset(1:i,:));
    theta3sequence(i)=q5theta3(dataset(1:i,:));
end
theta1sequence(n)
theta2sequence(n)
theta3sequence(n)

figure(1); hold on
title('Theta sequences from 1 to n')
a1 = plot(1:n,theta1sequence); M1="theta1";
a2 = plot(1:n,theta2sequence); M2="theta2";
a3 = plot(1:n,theta3sequence); M3="theta3";
a4 = plot(1:n,ones(n,1));
legend([a1, a2, a3],[M1, M2, M3])

hold off
e = size(6000:n);
sizeofe=size(e);
numb = sizeofe(1);
figure(2); hold on
title('Theta sequences from 6000 to n')
b1 = plot(6000:n,theta1sequence(6000:n)); Mb1="theta1";
b2 = plot(6000:n,theta2sequence(6000:n)); Mb2="theta2";
b3 = plot(6000:n,theta3sequence(6000:n)); Mb3="theta3";
b4 = plot(6000:n,ones(numb,1));
legend([b1, b2, b3],[Mb1, Mb2, Mb3])

hold off

difference = theta2sequence-theta3sequence;
figure(3); hold on
title('Difference between theta2 and theta3 from 600 to n')
a5 = plot(6000:n,difference(6000:n));
    