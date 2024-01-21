function [fAnd,phi,W ,Z] = getAndI_robust(formula,args,k,W ,Z)

% m*N binvar: a binary variable for each argument and agent 
z = [];

% Constraints
fAnd = [];

% number of arguments
m = length(args);

for i=1:m
    if ischar(args{i}) % If argument is a formula
        % Get its constraints
        [fAP,phiAP,W ,Z] = getLTL_robust(args{i},k,W ,Z);
        fAnd = [fAnd, fAP];
        z = [z; phiAP];
    else % if argument is atomic proposition
            
                wi = args{i};  
                [ztemp,Z] = getZ(args{i},h,N,Z);
                z = [z; ztemp(k,:)]; 

      for n = 1:N
                   
                    fAnd = [fAnd, sum(W{n}(wi,k))>=1+epsilon-bigM*(1-z(end,n))]; 
                    fAnd = [fAnd, sum(W{n}(wi,k))<=bigM*z(end,n)-epsilon];
            end  

    end
end

if m > 1
    % a binary variable for each agent
    [phi,Z] = getZ(formula,h,N,Z);
    phi = phi(k,:);  
    % conjunction constraint
    for n = 1:N
        fAnd = [fAnd, repmat(phi(n),m,1)<=z(:,n), phi(n)>=1-m+sum(z(:,n))]; 
    end
else
    phi = z;
end