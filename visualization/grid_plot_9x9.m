function grid_plot_6x6(sourcefile_name,mygrid)
load(sourcefile_name)
% grid-size is 9*9

k = length(ZLoop);
loopBegins = find(ZLoop(:)==1,1);

% Gives state vector index in loop at 'time'
time_to_state_pos = @(time) (time<=k)*(time) + (time>k)*(loopBegins + mod(time-k-1, k-loopBegins+1));

% Return coordinates in a grid world
ind_to_pos_x = @(ind) 1.69*(floor((ind-1)/9));
ind_to_pos_y = @(ind) 1.7*(mod((ind-1),9));

I = size(A,2);  % num of states
N = length(W);   % num of agents
K = 2*size(W{1},2)   % horizon

traces = zeros(N, K);

% Populate rest of traces
for k=1:(h+1)   %here 20 is the planning horizon
	t = time_to_state_pos(k);
	for agent=1:N
		traces(agent, k) = find(abs(W{agent}(:,t)-1)< 1e-4); %返回agent在k时刻的位置    
	end
end


clf; %clear image window
set(gca, 'LooseInset', get(gca,'TightInset'))


T = 1:(h+1);
cmap = jet(N); 
axis off
ha = tight_subplot(4,4, [0.01 0.1], [0.01 0.01], 0.05); 
for i=1:length(T)
	axes(ha(i))
	hold on; xlim([0.5, 15.5]); ylim([0.5, 15.5])
	imshow(kron(mygrid,ones(25,25)), 'xdata', [0.5,15.5], 'ydata', [0.5,15.5])   
    
	rectangle('position',[0.5 0.5 15 15],'LineWidth',2);   

	for n=1:N
		current_state = traces(n, T(i)); 
		diff_ = [1.3 1.2];   
		xpos = ind_to_pos_x(current_state) + diff_(1);  
		ypos = ind_to_pos_y(current_state) + diff_(2); 
		plot(xpos, ypos, 'o', 'color', cmap(n,:), ...
			'markersize', 2, 'MarkerFaceColor', cmap(n,:))
		if (current_state ~= traces(n, T(i)+1) && i~=length(T))  
            arrow_dest_x = ind_to_pos_x(traces(n, T(i)+1))+ diff_(1);
			arrow_dest_y = ind_to_pos_y(traces(n, T(i)+1))+ diff_(2);
			arrow([xpos, ypos], [arrow_dest_x, arrow_dest_y], 'length', 2,'width',0.7, 'baseangle', 90, 'tipangle', 30, 'color', cmap(n,:));
		end
	end

end
print -depsc traces.eps

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,sourcefile_name,'-dpdf')


