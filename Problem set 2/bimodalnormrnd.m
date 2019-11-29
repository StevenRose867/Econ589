function ret = bimodalnormrnd(n,var)

ret = zeros(n,1);
% n is number of points you want to draw
ind = unidrnd(2,n,1);
for i = 1:n
    if ind(i) == 1
        ret(i) = normrnd(-1.5,var);
    end
    if ind(i) == 2
        ret (i) = normrnd(1.5,var);
    end
end
