function [density,codeInd] = updateDensity(traj,xg,yg,cellLen)
traj_num = numel(traj);
codeSub = cell(traj_num,1);
codeInd = cell(traj_num,1);
xg1 = xg(1);
yg1 = yg(1);
parfor i = 1:traj_num
    newTraj = traj{i}*cellLen + repmat([xg1,yg1],size(traj{i},1),1);
    codeSub{i} = encodeEnGrid(newTraj,xg,yg,cellLen);
    codeInd{i} = sub2ind([numel(yg),numel(xg)],codeSub{i}(:,1),codeSub{i}(:,2));
end
total_code = cell2mat(codeSub);
density = zeros(numel(yg),numel(xg));
for i = 1:size(total_code)
    density(total_code(i,1),total_code(i,2)) = density(total_code(i,1),total_code(i,2)) + 1;
end
