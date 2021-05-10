function newTraj = slide(density,traj,cellLen)
traj_num = numel(traj);
newTraj = cell(traj_num,1);
parfor i = 1:traj_num
    if size(traj{i},1) == 1
        newTraj{i} = traj{i};
    elseif size(traj{i},1) == 2
        traj{i} = [traj{i}(1,:);(traj{i}(1,:)+traj{i}(2,:))/2;traj{i}(2,:)];
        newTraj{i} = slideOnOneTrajectory(density,traj{i},cellLen);
    else
        newTraj{i} = slideOnOneTrajectory(density,traj{i},cellLen);
    end
end
