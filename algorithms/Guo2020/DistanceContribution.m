function distance = DistanceContribution(pointAdjacentMatrix)
distance = zeros(size(pointAdjacentMatrix,1),2);
v = pointAdjacentMatrix(:,3:4) - pointAdjacentMatrix(:,1:2);
u = pointAdjacentMatrix(:,5:6) - pointAdjacentMatrix(:,1:2);
dot = sum(u.^2,2);
loc = find(dot>0);

center = u(loc,:).*(sum(v(loc,:).*u(loc,:),2)./dot(loc,:)) + pointAdjacentMatrix(loc,1:2);
m2 = pointAdjacentMatrix(loc,5:6) - center;
m1 = pointAdjacentMatrix(loc,1:2) - center;

distance(loc,:) = (m1+m2)/2;

% distance(loc,:) = (m1+m2);
