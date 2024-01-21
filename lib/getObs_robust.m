function [fObs,W] = getObs_robust(Obs,W)
% returns collision avoidance constraints


% number of agents
N = length(W);

% Obstacle avoidance constraints
fObs= [];

for n = 1:N
    W{n}(Obs,:) = 0;
end
