function newTraj = resampleTra(traj,ResampleInterval)
traj_num = numel(traj);
newTraj = cell(traj_num,1);
parfor i = 1:traj_num
    temp = traj{i};
    temp(diff(temp(:,1))==0&diff(temp(:,2))==0,:) = [];
    if size(temp,1)==1
        newTraj{i} = temp;
    else
        d = diff(temp); % EDIT
        total_length = sum(sqrt(sum(d.*d,2)));
        resample_num = ceil(total_length/ResampleInterval);
        newTraj{i} = interparc(resample_num,temp(:,1),temp(:,2),'linear');
    end
end
