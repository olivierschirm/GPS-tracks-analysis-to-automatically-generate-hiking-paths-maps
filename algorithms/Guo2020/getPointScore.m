function pscore = getPointScore(density,traj,pNum)
pscore = zeros(pNum,1);
if max(traj(:,1))>size(density,1) || max(traj(:,2))>size(density,2) || min(traj(:,1))<=0 || min(traj(:,2))<=0
    error('The point index is out of range!');
end
for i = 1:pNum
    index = sub2ind(size(density),traj(i,1),traj(i,2));
    if index>size(density,1)*size(density,2)
        error('The index is wrong!');
    end
    pscore(i) = density(index);
end