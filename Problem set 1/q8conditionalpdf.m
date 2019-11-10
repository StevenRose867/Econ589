function fx = q8conditionalpdf(x,y)

fx = q8jointpdf(x,y)/normpdf(y);