function ret = crossvalidation(k,X)
% finds the cross-validation bandwidth given kernel k and data X

objective = @(h) -cvobj(h,k,X); %minus sign since we will use fminsearch
ret = fminsearch(objective,1);