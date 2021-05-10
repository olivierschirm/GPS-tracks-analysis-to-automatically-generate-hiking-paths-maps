function code =  encodeLineSegmentEnGrid(x1,x2,y1,y2,cellLen,xg,yg)
x1Grid = (x1-xg(1))/cellLen;
y1Grid = (y1-yg(1))/cellLen;
x2Grid = (x2-xg(1))/cellLen;
y2Grid = (y2-yg(1))/cellLen;
i1 = ceil(x1Grid);
j1 = ceil(y1Grid);
i2 = ceil(x2Grid);
j2 = ceil(y2Grid);

if i1==i2 % vertical parallel
    if j1==j2
        code = [j1,i1;j2,i2];
    elseif j1<j2
        code = [(j1:j2)',repmat(i1,j2-j1+1,1)];
    else
        code = [flipud((j2:j1)'),repmat(i1,j1-j2+1,1)];
    end
elseif j1==j2 % horizonal parallel
    if i1<i2
        code = [repmat(j1,i2-i1+1,1),(i1:i2)'];
    else
        code = [repmat(j1,i1-i2+1,1),flipud((i2:i1)')];
    end
else
    % - calculate the intersections with cells
    x_range = min(i1,i2)*cellLen+xg(1):cellLen:(max(i1,i2)-1)*cellLen+xg(1);
    y_range = min(j1,j2)*cellLen+yg(1):cellLen:(max(j1,j2)-1)*cellLen+yg(1);
    intersects = fliplr(lineIntersectsGrid(x1,x2,y1,y2,x_range,y_range));
    intersect1 = intersects(1:end-1,:);
    intersect2 = intersects(2:end,:);
    inter_label = ceil(((intersect1+intersect2)/2-repmat([yg(1),xg(1)],size(intersect1,1),1))/cellLen);
    code = [j1,i1;inter_label;j2,i2];
end
