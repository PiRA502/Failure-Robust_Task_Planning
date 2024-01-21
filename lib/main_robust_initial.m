function [W, ZLoop, mytimes, sol, obj] = main_robust_initial(formula,A,h,W0,Obs,CA_flag,k,gurobi_method,alpha,opt)
% failure-robust algorithm for initial robustness 

% formula - overall task
% A - workspace
% h - time horizon
% W0 - initial states of robots
% Obs - obstacle
% k - maximum number of potential broken robot

time = clock;
disp([ 'Started at ', ...
num2str(time(4)), ':',... % Returns year as character
num2str(time(5)), ' on ',... % Returns month as character
num2str(time(3)), '/',... % Returns day as char
num2str(time(2)), '/',... % returns hour as char..
num2str(time(1))]);

if h==0
    disp('Trajectory must be greater than 0');
    assert(h>0);
end

tos = tic;

% Number of agents
N = sum(W0);

% Number of states
I = length(A);

% Control input
W = binvar(repmat(I,1,N),repmat(h+1,1,N),'full'); 

k_num = nchoosek(N,k);

if N == 1
     W = {W};
end


% Initial state constraint
disp('Creating other constraints...')

[fInit,W] = getInit_robust(W0,W);

% Obstacle Avoidence Constraint
[fObs,W] = getObs_robust(Obs,W);

% System dynamics constraint
[fDyn,W] = getDyn_robust(A,CA_flag,W);

% Timing of other constraints
toe = toc(tos);
disp(['    Done with other constraints (',num2str(toe),') seconds'])


tlrobust=tic;

fRobust = [];
for i = 1 : k_num
    eval(['W_R',num2str(i),' = binvar(repmat(I,1,N),repmat(h+1,1,N),''full'');']);
    for j = 1:N
        if (i ~=j)
            eval(['fRobust = [fRobust, W_R',int2str(i),'{j} == W{j}];']);
        else
            eval(['W_R',int2str(i),'{j} = zeros(I,h+1);']);
        end
    end
end

tlrobust2 = toc(tlrobust);
disp(['    Done with Robust constraints (',num2str(tlrobust2),') seconds'])


% LTL constraint
disp('Creating LTL constraints...')
tltls=tic; 
for i = 1 : k_num
    eval(['Z',int2str(i),' = {};']);
    eval(['[fLTL',int2str(i),',phi',int2str(i),',W_R',int2str(i),',Z',int2str(i),'] = getLTL_robust(formula,1,W_R',int2str(i),',Z',int2str(i),');']);
end


tltle=toc(tltls);
disp(['    Done with LTL constraints (',num2str(tltle),') seconds'])

% Solve the optimization problem

tms=tic;   %MILP start time

% All Constraints
F = [fInit, fDyn, fObs, fRobust];
for i = 1:k_num
    eval(['F = [F, fLTL',int2str(i),', phi',int2str(i),' == 1];']);
end


disp(['    Total number of optimization variables : ', num2str(length(depends(F)))]);

% MILP solver parameter
options = sdpsettings('verbose',8,'solver','gurobi','gurobi.Method',gurobi_method,'gurobi.TimeLimit',7200,'gurobi.PoolSearchMode',1);
options.gurobi.Heuristics = 0.8;
options.gurobi.MIPFocus = 1;
disp('Solving MILP...')

if opt == true
    sol = optimize(F,obj,options);
    disp("yes")
else
    sol = optimize(F,{},options); 
    disp("no")
end

tme=toc(tms); 
disp(['    Solved solvertime(',num2str(sol.solvertime),') seconds'])
disp(['    Solved yalmiptime(',num2str(sol.yalmiptime),') seconds'])
disp(['    Solved tmetime(',num2str(tme),') seconds'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assign values

if sol.problem == 0
    disp('## Feasible solution exists ##')
   
    for n = 1:N
        W{n} = value(W{n});
        for i = 1:k_num
            eval(['W_R',int2str(i),'{n} = value(W_R',int2str(i),'{n});']);
        end
    end

    for i = 1:k_num
        for j=1:(length(Z1))
        eval(['Z',int2str(i),'{j}{1} = value(Z',int2str(i),'{j}{1});']);
        end
    end

    for i =1:k_num
        eval(['phi',int2str(i),' = value(phi',int2str(i),');']);
    end

    obj = value(obj);


    for i = 1:k_num
        eval(['save W_R',int2str(i),' W_R',int2str(i),';']);
        eval(['save Z',int2str(i),' Z',int2str(i),';']);
        eval(['save phi',int2str(i),' phi',int2str(i),';']);
    end


else
     W=0;WT=0;ZLoop=0;zLoop=0;LoopBegins=0;
     sol.info
     yalmiperror(sol.problem)
     assert(0,'## No feasible solutions found! ##');
end

ttotal = toc(tos);
mytimes = [ttotal,toe, tltle, sol.solvertime]
yalmip('clear')