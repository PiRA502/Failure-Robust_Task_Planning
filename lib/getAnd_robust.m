function [fAnd,phi, W, Z] = getAnd_robust(formula,args,k, W, Z)

% m*N binvar: a binary variable for each argument and agent 
z = [];

% Constraints
fAnd = [];

% number of arguments
m = length(args);

for i=1:m
    % Get its constraints
    [fAP,phiAP,W,Z] = getLTL_robust(args{i},k,W, Z);
    fAnd = [fAnd, fAP];
    z = [z; phiAP];
end

if m > 1
    % a binary variable
    [phi,Z] = getZ(formula,h,1,Z);
    phi = phi(k);
    % conjunction constraint
    fAnd = [fAnd, repmat(phi,m,1)<=z, phi>=1-m+sum(z)]; %和paper对应，是编码部分
else
    phi = z;
end