function angle = AngleContribution(pointAdjacentMatrix)
angle = zeros(size(pointAdjacentMatrix,1),2);
n1 = pointAdjacentMatrix(:,1:2) - pointAdjacentMatrix(:,3:4);
n2 = pointAdjacentMatrix(:,5:6) - pointAdjacentMatrix(:,1:2);
len1 = sqrt(sum(n1.^2,2));
len2 = sqrt(sum(n2.^2,2));
loc1 = find(len1>0);
loc2 = find(len2>0);
n1(loc1,:) = n1(loc1,:)./len1(loc1);
n2(loc2,:) = n2(loc2,:)./len2(loc2);

factor = 1 + nthroot(sum(n2.*n1,2),3);

loc = find(factor~=0&sum((n1+n2).^2,2)~=0);
if ~isempty(loc)
    angle(loc,:)= (n1(loc,:)+n2(loc,:))./sqrt(sum((n1(loc,:)+n2(loc,:)).^2,2)).*min([len1(loc),len2(loc)],[],2).*factor(loc,:);
end
