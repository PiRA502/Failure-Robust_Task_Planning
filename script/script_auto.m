
timestamp = datestr(now,'mmdd-HHMM');
eval(['diary ',timestamp,'.txt'])

time1 =[];
time2 =[];
time3 =[];
time4 =[];
W0_list1 = [];
W0_list2 = [];
W0_list3 = [];
W0_list4 = [];
grid_list1 = {};
grid_list2 = {};
grid_list3 = {};
grid_list4 = {};

i = 0;
while i < 31
    i = i + 1
    
    timestamp = datestr(now,'mmdd-HHMM')

    % initialize the map
    grid_size = [5,5];
    [mygrid,A] = initGrid(grid_size);
    
    state_labels = mygrid(:);
    
    Pass = find(state_labels(:)==0.2)';
    pass = num2str(Pass);
    R_1 = find(state_labels(:)==0.4)';
    r_1 = num2str(R_1);
    R_2 = find(state_labels(:)==0.45)';
    r_2 = num2str(R_2);
    D = find(state_labels(:)==0.6)';
    d = num2str(D);
    V_1 = find(state_labels(:)==0.8)';
    v_1 = num2str(V_1);
    V_2 = find(state_labels(:)==0.85)';
    v_2 = num2str(V_2);
    U = find(state_labels(:)==0.5)'; 
    u = num2str(U);
   
    Obs = state_labels(:)==0;                   %avoid obstacles
    Obs_ = find(state_labels(:)==0)';

    % initialize the robot
    N = 8;   % robot number
    blacklist=[R_2,Obs_];
    W0 = initW(A,N,blacklist);
    %%%%%%%%%%%%
    test_ltl_k_1(W0, mygrid, A, 'global', false); 
    load mytimes;
  
  time1 = [time1; mytimes];
    W0_list1 = [W0_list1, W0];
    grid_list1{length(grid_list1)+1} = mygrid;

end
% 
save time1
save W0_list1
save  grid_list1
% 


i = 0;
while i < 31
    i = i + 1
    
    timestamp = datestr(now,'mmdd-HHMM')
    
    % initialize the map
    grid_size = [5,5];
    [mygrid,A] = initGrid(grid_size);
    
    state_labels = mygrid(:);
    
    Pass = find(state_labels(:)==0.2)';
    pass = num2str(Pass);
    R_1 = find(state_labels(:)==0.4)';
    r_1 = num2str(R_1);
    R_2 = find(state_labels(:)==0.45)';
    r_2 = num2str(R_2);
    D = find(state_labels(:)==0.6)';
    d = num2str(D);
    V_1 = find(state_labels(:)==0.8)';
    v_1 = num2str(V_1);
    V_2 = find(state_labels(:)==0.85)';
    v_2 = num2str(V_2);
    U = find(state_labels(:)==0.5)'; 
    u = num2str(U);
   
    Obs = state_labels(:)==0;                   %avoid obstacles
    Obs_ = find(state_labels(:)==0)';

    % initialize the robot
    N = 8;   % robot number
    blacklist=[R_2,Obs_];
    W0 = initW(A,N,blacklist);
    %%%%%%%%%%%%
    test_ltl_2(W0, mygrid, A, 'global', false); 
    load mytimes;
    time2 = [time2; mytimes];
    W0_list2 = [W0_list2, W0];
    grid_list2{length(grid_list2)+1} = mygrid;

end
% 
save time2
save W0_list2
save  grid_list2
% 


i = 0;
while i < 31
    i = i + 1
    
    timestamp = datestr(now,'mmdd-HHMM')
    
    % initialize the map
    grid_size = [5,5];
    [mygrid,A] = initGrid(grid_size);
    
    state_labels = mygrid(:);
    
    Pass = find(state_labels(:)==0.2)';
    pass = num2str(Pass);
    R_1 = find(state_labels(:)==0.4)';
    r_1 = num2str(R_1);
    R_2 = find(state_labels(:)==0.45)';
    r_2 = num2str(R_2);
    D = find(state_labels(:)==0.6)';
    d = num2str(D);
    V_1 = find(state_labels(:)==0.8)';
    v_1 = num2str(V_1);
    V_2 = find(state_labels(:)==0.85)';
    v_2 = num2str(V_2);
    U = find(state_labels(:)==0.5)'; 
    u = num2str(U);
   
    Obs = state_labels(:)==0;                   %avoid obstacles
    Obs_ = find(state_labels(:)==0)';

    % initialize the robot
    N = 8;   % robot number
    blacklist=[R_2,Obs_];
    W0 = initW(A,N,blacklist);
    %%%%%%%%%%%%
    test_ltl_3(W0, mygrid, A, 'global', false); 
    load mytimes;
    time3 = [time3; mytimes];
    W0_list3 = [W0_list3, W0];
    grid_list3{length(grid_list3)+1} = mygrid;

end
% 
save time3
save W0_list3
save  grid_list3
% 


i = 0;
while i < 31
    i = i + 1
    
    timestamp = datestr(now,'mmdd-HHMM')
    
    % initialize the map
    grid_size = [5,5];
    [mygrid,A] = initGrid(grid_size);
    
    state_labels = mygrid(:);
    
    Pass = find(state_labels(:)==0.2)';
    pass = num2str(Pass);
    R_1 = find(state_labels(:)==0.4)';
    r_1 = num2str(R_1);
    R_2 = find(state_labels(:)==0.45)';
    r_2 = num2str(R_2);
    D = find(state_labels(:)==0.6)';
    d = num2str(D);
    V_1 = find(state_labels(:)==0.8)';
    v_1 = num2str(V_1);
    V_2 = find(state_labels(:)==0.85)';
    v_2 = num2str(V_2);
    U = find(state_labels(:)==0.5)'; 
    u = num2str(U);
   
    Obs = state_labels(:)==0;                   %avoid obstacles
    Obs_ = find(state_labels(:)==0)';

    % initialize the robot
    N = 8;   % robot number
    blacklist=[R_2,Obs_];
    W0 = initW(A,N,blacklist);
    %%%%%%%%%%%%
    test_ltl_4(W0, mygrid, A, 'global', false); 
    load mytimes;
    time4 = [time4; mytimes];
    W0_list4 = [W0_list4, W0];
    grid_list4{length(grid_list3)+1} = mygrid;

end
% 
save time4
save W0_list4
save  grid_list4
% 
