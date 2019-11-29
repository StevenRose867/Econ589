function ret = MLEnormd(data,Theta)

objective = @(theta) Lnorm(data,theta);
fval = objective(Theta(1));
ret = Theta(1);
for i =1:length(Theta)
    if objective(Theta(i))>fval
        fval = objective(Theta(i));
        ret = Theta(i);
    end
end
