function code_traj = encodeEnGrid(T,xg,yg,cellLen)
Tlength = size(T,1);
if Tlength==1
    i1 = ceil((T(1)-xg(1))/cellLen);%column i1<i2
    j1 = ceil((T(2)-yg(1))/cellLen);%row j1<j2
    code_traj = [j1,i1];
else
    code_line = cell(Tlength-1,1);
    for i = 1:Tlength-1
        % - encode line segment
        code_line{i} = encodeLineSegmentEnGrid(T(i,1),T(i+1,1),T(i,2),T(i+1,2),cellLen,xg,yg);
        if i>1
            code_line{i}(1,:) = [];
        end
    end
    code_traj = cell2mat(code_line);
end

code_traj(diff(code_traj(:,1))==0&diff(code_traj(:,2))==0,:) = [];
