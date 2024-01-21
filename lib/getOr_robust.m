function [fOr,phi,W, Z] = getOr_robust(formula,args,k,W, Z)

% a binary variable for each argument
z = [];

% Constraints
fOr = [];

% number of arguments
m = length(args);


for i=1:m
    if ischar(args{i}) 
        [fAP,phiAP,W, Z] = getLTL_robust(args{i},k,W, Z);
        fOr = [fOr, fAP];
        z = [z;phiAP];
    else 
        ztemp = [getZ(args{i},k)];
        z = [z;ztemp];
        wi = args{i}(1:end-1);
        mi = args{i}(end);

        fOr = [fOr, sum(W(wi))>=mi+epsilon-bigM*(1-z(i))];
        fOr = [fOr, sum(W(wi))<=mi-epsilon+bigM*z(i)-1];
    end
end

if m > 1
    % a binary variable for formula
    [phi,Z] = getZ(formula,h,1,Z);
    phi = phi(k,:);
    fOr = [fOr, repmat(phi,m,1)>=z, phi<=sum(z)];
else
    phi = z;
end