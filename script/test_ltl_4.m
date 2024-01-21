
function test_ltl_4 (W0, mygrid, A, choose_algorithm, opt)
close all;
addpath(genpath('../'))

% gurobi paramer
gurobi_method = -1;
% algorithm optition（initial / global)
% choose_algorithm = 'global'; 
% opt = true; 

if opt == true
    filename_mini = [
    datestr(now,'mmdd-HHMM_') ...
    choose_algorithm ...
    '_gurobiMethod_' ...
    int2str(gurobi_method)...
    '_test_ltl_1_cost'
    ];
else
    filename_mini = [
    datestr(now,'mmdd-HHMM_') ...
    choose_algorithm ...
    '_gurobiMethod_' ...
    int2str(gurobi_method)...
    '_test_ltl_1'
    ];
end

filename = ['../data/' ...
filename_mini
];

mkdir(filename);


eval(['fid=fopen("',filename,'/',filename_mini,'.txt","w");']);
fclose(fid); % close the file

eval(['diary ',filename,'/',filename_mini,'.txt'])

% Time horizon
h = 20;
% robustness number
disp('the maximum number of broken robots is ...')
k = 3;  %the maximum number of broken robots

Obs = state_labels(:)==0;                 
Obs_ = find(state_labels(:)==0)';

% visualization
vis = zeros(size(mygrid)+2);
vis(2:end-1,2:end-1)=mygrid;

f1 = strcat('Neg([',r_2,'])');
f2 = strcat(v_1);
f3 = strcat('F[',r_2,']');
f4 = strcat(v_2);
f5 = strcat('U(',f1,',',f4,')');

f = strcat('And(',f5,',',f3,')');


% number of robots
n = size(A,1);
blacklist=[R_2,Obs_];
% number of states
I = length(A); 

% Collision avoidence flag,
% 1=collision avoidence enforced, 0=no collision avoidence
CA_flag = 0;

if strcmp(choose_algorithm,'initial')
    [W, ZLoop, mytimes, sol, obj] = main_robust_initial_k_3(f,A,h,W0,Obs,CA_flag,k,gurobi_method,alpha,opt);
else
    [W, ZLoop, mytimes, sol, obj] = main_robust_global_k_3(f,A,h,W0,Obs,CA_flag,k,gurobi_method,alpha,opt);
end

disp(['    Solved TOTALtime(',num2str(mytimes(1)),') seconds'])

% display the result
for i = 1:k_num
    eval(['load(''W_R',int2str(i),'.mat'');']);
    eval(['load(''Z',int2str(i),'.mat'');']);
    eval(['load(''phi',int2str(i),'.mat'');']);
end
disp(filename);

mat_name = [filename ,'/',filename_mini];
save(mat_name);


% delete temporary files
for i = 1:k_num
    eval(['delete ("W_R',int2str(i),'.mat");']);
    eval(['delete ("Z',int2str(i),'.mat");']);
    eval(['delete ("phi',int2str(i),'.mat");']);
end

save mytimes mytimes;
diary off


