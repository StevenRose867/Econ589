function fxy = q8fjointpdf(x,y)

c = (1+2*(1-exp(-1/2))^(2))/pi;

ind = 1;
if abs(x)>1
    ind = 0;
end
if abs(y)>1
    ind = 0;
end

fxy = c.*normpdf(x).*normpdf(y).*(1+abs(x).*abs(y).*ind);
