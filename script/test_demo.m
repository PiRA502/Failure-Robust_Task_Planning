clear;
close all;
clc;
addpath(genpath('../'))
%%%%%%%%%%%%%%%%%%%%
% simple LTL task
% script test
%%%%%%%%%%%%%%%%%%%%

% gurobi parameter
gurobi_method = -1;
% failure-robust algorithm（initial / global)
choose_algorithm = 'global'; 

filename = ['../data/' ...
datestr(now,'mmdd-HHMM_') ...
choose_algorithm ...
'_gurobiMethod_' ...
int2str(gurobi_method)...
'_test_demo_cost'
];

filename_mini = [
choose_algorithm ...
'_gurobiMethod_' ...
int2str(gurobi_method)...
'_test_demo_cost'
];

mkdir(filename);

eval(['fid=fopen("',filename,'/',filename_mini,'.txt","w");']);
fclose(fid); 

eval(['diary ',filename,'/',filename_mini,'.txt'])

% Time horizon
h = 6;
% robustness number
epsilon = 0; 
tau = 0;
disp('the maximum number of broken robots is ...')
k = 1;  %the maximum number of broken robots

% define a gridworld
grid_size = [10,10];
mygrid = ones(grid_size);

% 0-obstacle; 0.4-r;0.6-d; 0.8-v; 0.5-u;0.2-for the rest
mygrid(1:10,1:10) = 0.2;
mygrid(1, 1) = 0.4;
mygrid(1, 10) = 0.4;
mygrid(10, 10) = 0.4;
mygrid(10, 1) = 0.4;

mygrid(5, 1) = 0.6;
mygrid(1, 5) = 0.6;
mygrid(10, 5) = 0.6;
mygrid(6, 10) = 0.6;

mygrid(5,5) = 0.5;

mygrid(3,8) = 0.8;
mygrid(8,8) = 0.8;

mygrid(4,4:9) = 0;
mygrid(5:6,8:9) = 0;
mygrid(7,4:9) = 0;
%%%%%%%%%%% 

state_labels = mygrid(:);

Pass = find(state_labels(:)==0.2)';
pass = num2str(Pass);
R = find(state_labels(:)==0.4)';
r = num2str(R);
D = find(state_labels(:)==0.6)';
d = num2str(D);
V = find(state_labels(:)==0.8)';
v = num2str(V);
U = find(state_labels(:)==0.5)';
u = num2str(U);

Obs = state_labels(:)==0;                 


% visualization
vis = zeros(size(mygrid)+2);
vis(2:end-1,2:end-1)=mygrid;
imshow(kron(vis,ones(25,25))) 




% f1 = strcat('GF([',u,'])');        % GF([0.4 labels, >=2])
% f2 = strcat('GF([',b,'])');        % GF([0.6 labels, >=2])        
% f3 = strcat('GF([',c,'])'); 
f4 = strcat('GF(TP([',u,'],[1]))');
f5 = strcat('GF(TP([',r,'],[1]))');
f6 = strcat('Neg(TP([',d,'],[1]))');
f7 = strcat('TP([',v,'],[1])');

% f = strcat('Or(',f6,')');
f = strcat('U(',f6,',',f7,')');
% f = f4


adj = eye(numel(mygrid));      

for i=1:length(state_labels)
    if mod(i, grid_size(1))~=0 
        adj(i, i+1) = 1;
    end
    if mod(i, grid_size(1))~=1
        adj(i, i-1) = 1;
    end
    if i<=grid_size(1)*(grid_size(2)-1)
        adj(i, i+grid_size(1)) = 1;
    end
    if i>grid_size(1)
        adj(i, i-grid_size(1)) = 1;
    end
    
end

% Adjacency matrix
A = adj;


n = size(A,1);
W0 = [0; ones(3,1); zeros(n-4,1)];


N = sum(W0); 
I = length(A); 


if strcmp(choose_algorithm,'initial')
    [W, ZLoop, mytimes, sol, obj] = main_robust_initial(f,A,h,W0,Obs,CA_flag,k,gurobi_method,alpha);
else
    [W, ZLoop, mytimes, sol] = main_robust_global(f,A,h,W0,Obs,CA_flag,k,gurobi_method,alpha);
end

disp(['    Solved TOTALtime(',num2str(mytimes(1)),') seconds'])


for i = 1:k_num
    eval(['load(''W_R',int2str(i),'.mat'');']);
    eval(['load(''Z',int2str(i),'.mat'');']);
    eval(['load(''phi',int2str(i),'.mat'');']);
end

disp(filename);

mat_name = [filename ,'/',filename_mini];
save(mat_name);

grid_plot(mat_name);  

for i = 1:k_num
    eval(['delete ("W_R',int2str(i),'.mat");']);
    eval(['delete ("Z',int2str(i),'.mat");']);
    eval(['delete ("phi',int2str(i),'.mat");']);
end


diary off

