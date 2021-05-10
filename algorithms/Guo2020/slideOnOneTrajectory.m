function newTraj = slideOnOneTrajectory(density,traj,cellLen)
[row,column] = size(density);
points_num = size(traj,1);
preCorrections = zeros(points_num,2);
gradientV = zeros(points_num,2);
distanceV = zeros(points_num,2);
angleV = zeros(points_num,2);
[currentScore,densityNei] = pathScoreCompute(density,traj);

%do the correction on each point
for loop = 1:4000
    gradientV(2:points_num-1,:) = GradientContribution(densityNei(2:points_num-1,:),traj(2:points_num-1,:),cellLen);
    pointAdjacentMatrix = [traj(1:points_num-2,:),traj(2:points_num-1,:),traj(3:points_num,:)];
    distanceV(2:points_num-1,:) = DistanceContribution(pointAdjacentMatrix);
    angleV(2:points_num-1,:) = AngleContribution(pointAdjacentMatrix);
    correction = gradientV*0.5 + distanceV*0.2 + angleV*0.1 + preCorrections*0.7;
    newTraj = traj + correction;
    newTraj(1,:) = getSpPoint(newTraj(2,:),newTraj(3,:),traj(1,:));
    newTraj(points_num,:) = getSpPoint(newTraj(points_num-1,:),newTraj(points_num-2,:),traj(points_num,:));
    newTraj(newTraj<1) = 1;
    newTraj(newTraj(:,1)>column,1) = column;
    newTraj(newTraj(:,2)>row,2) = row;
    [pathScore,densityNei] = pathScoreCompute(density,newTraj);
    previousScore = currentScore;
    currentScore = 0.2*previousScore + 0.8*pathScore;
    delta = abs(currentScore-previousScore);
    if loop>100&&delta<5*10^(-4)
        break;
    end
    traj = newTraj;
    preCorrections = correction;
end
