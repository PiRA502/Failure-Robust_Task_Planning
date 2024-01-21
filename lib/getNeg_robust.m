function [fNeg,phi, W, Z] = getNeg_robust(formula,args,k, W, Z)


if length(args)>1
    disp('Negation takes a single argument');
    assert(length(args)==1);
end

% number of agents
N = length(W);
% number of states
I = size(W{1},1);
% time horizon
h = size(W{1},2)-1;

% Get its constraints
[fNeg,z,W, Z] = getLTL_robust(args{1},k,W, Z);

phi = getZ(formula,h,1,Z);   
phi = phi(k); 

fNeg = [fNeg, phi == 1-z];