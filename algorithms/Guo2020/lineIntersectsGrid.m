function intersects = lineIntersectsGrid(x1,x2,y1,y2,x_range,y_range)
m = (y2-y1)/(x2-x1);% % Slope (or slope array)
b = y1-m*x1;% Intercept (or intercept array)
mb = [m b];% Matrix of [slope intercept] values
lxmb = @(x_range,mb) m.*x_range + b;% - line equation: y=m*x+b
hix = @(y_range,mb) [(y_range-b)./m;y_range];% - horizontal intersecpts
vix = @(x_range,mb) [x_range;lxmb(x_range,mb)];
hrz = hix(y_range,mb)';           % [X Y] Matrix of horizontal intercepts
vrt = vix(x_range,mb)';             % [X Y] Matrix of vertical intercepts
hvix = [hrz; vrt];                 % Concatanated �hrz� and �vrt� arrays
intersects = unique(hvix,'rows');        % Remove repeats and sort ascending by �x�