function [mygrid, A] = initGrid(grid_size)
    mygrid = ones(grid_size);
    mygrid(:, :) = 0.2;

    row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0;

    row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0;

        row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 1;

    row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0.95;

        row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0.96;

    row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0.97;

        row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0.98;

        row = randi(grid_size(1));
    col = randi(grid_size(2));
    while mygrid(row, col) ~= 0.2
        row = randi(grid_size(1));
        col = randi(grid_size(2));
    end
    mygrid(row, col) = 0.99;


adj = eye(numel(mygrid));       
state_labels = mygrid(:);

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





    