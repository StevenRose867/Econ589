for i= 1:8
    adeerrors(i) = sqrt(sum(adedistances(:,i).^2));
    mserrors(i) = sqrt(sum(msdistances(:,i).^2));
end