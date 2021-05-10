function [pathScore,densityNei] = pathScoreCompute(density,traj)
[row,column] = size(density);
pointNum = size(traj,1);
densityNei = zeros(pointNum,4);%xy,x1y,xy1,x1y1
xiyi = floor(traj);
xi1yi1 = xiyi + 1;
xi1yi1(xi1yi1(:,1)>column,1) = column;
xi1yi1(xi1yi1(:,2)>row,2) = row;
deltaxy = traj - xiyi;
for i = 1:pointNum
    densityNei(i,1) = density(xiyi(i,2),xiyi(i,1));
    densityNei(i,2) = density(xiyi(i,2),xi1yi1(i,1));
    densityNei(i,3) = density(xi1yi1(i,2),xiyi(i,1));
    densityNei(i,4) = density(xi1yi1(i,2),xi1yi1(i,1));
end

w1 = densityNei(:,1).*(1-deltaxy(:,1)) + densityNei(:,2).*deltaxy(:,1);
w2 = densityNei(:,3).*(1-deltaxy(:,1)) + densityNei(:,4).*deltaxy(:,1);
pathScore = sum(w1.*(1-deltaxy(:,2)) + w2.*deltaxy(:,2))/pointNum;




