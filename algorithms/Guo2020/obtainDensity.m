function [xg,yg,density,trajectoryInGrid,codeOriginal] = obtainDensity(traj,cellLen)
traj_num = numel(traj);
code = cell(traj_num,1);
trajectoryInGrid = cell(traj_num,1);
codeOriginal = cell(traj_num,1);
[xg,yg] = buildGrid(traj,cellLen);
parfor i = 1:traj_num
    code{i} = encodeEnGrid(traj{i},xg,yg,cellLen);
    trajectoryInGrid{i} = (traj{i}-repmat([xg(1),yg(1)],size(traj{i},1),1))/cellLen;
    codeOriginal{i} = sub2ind([numel(yg),numel(xg)],code{i}(:,1),code{i}(:,2));
end
total_code = cell2mat(code);
density = zeros(numel(yg),numel(xg));
for i = 1:size(total_code)
    density(total_code(i,1),total_code(i,2)) = density(total_code(i,1),total_code(i,2)) + 1;
end
% density = density/sum(density(:));
