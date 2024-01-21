function W0 = initW(A, N, blacklist)

n = size(A,1);
W0=zeros(n,1);

for i=1:N
    t=randi(n);
    while (ismember(t, blacklist)) | (W0(t) == 1)
        t = randi(n);
        disp(t)
    end
    W0(t) = 1;
end