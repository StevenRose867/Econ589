function fy = q8fmarginalpdf(y)

c = (1+2*(1-exp(-1/2))^(2))/pi;

ind = 1;
if abs(y)>1
    ind = 0;
end

fy = c.*normpdf(y).*(1+sqrt(2).*abs(y).*ind.*(1-exp(-1/2))./sqrt(pi));