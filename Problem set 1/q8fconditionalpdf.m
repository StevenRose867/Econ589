function fx = q8fconditionalpdf(x,y)

fx = q8fjointpdf(x,y)./q8fmarginalpdf(y);