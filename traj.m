function T=traj(x1,M)
N=numel(x1);
for i=1:N-M+1
    T(i,:)=x1(i:i+M-1);
end