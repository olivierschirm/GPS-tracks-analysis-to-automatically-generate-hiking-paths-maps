function [pixelLink,link,link_xy,link_length,edgeG,vertexG,link_edge] = thin2GraphLink(bw,xMin,yMin,gridCellLength)
% function [link,edge] = thin2Graph(bw)
pixelLink = zeros(size(bw));
bpImage = bwmorph(bw,'branchpoints');%find the branch points
endpImage = bwmorph(bw,'endpoints');%find the endpoints
bpNode = find(bpImage);
endNode = find(endpImage);
node_intersect = [bpNode;endNode];
bw1 = bw;
bw1(node_intersect) = 0;
neighborBp = pk_get_8nh_idx(bw1,node_intersect);
subBpNodeAll = unique(neighborBp(neighborBp>0));
bw2 = bw1;
bw2(subBpNodeAll) = 0;
neighborNeigp = pk_get_8nh_idx(bw2,subBpNodeAll);
L = bwlabel(bw2);
edgeNum = max(L(:));
toCombineSubBpNode = [];
% delete the node and its neghbor to get the lables
% label the sub-bpNode, row,column---add the neighbor
for i = 1:numel(subBpNodeAll)
    neighborSubBp = neighborNeigp(i,:);
    labelsCenterSubBp = L(neighborSubBp(neighborSubBp>0));
    labelForSub = labelsCenterSubBp(labelsCenterSubBp>0);
    if numel(labelForSub)>0
        L(subBpNodeAll(i)) = labelForSub;
    else
        toCombineSubBpNode = [toCombineSubBpNode,subBpNodeAll(i)];
    end
end

% determine combine pairwise sub-bpNode or not
for i = 1:numel(toCombineSubBpNode)
    if toCombineSubBpNode(i)>0
        locLink = find(ismember(neighborBp,toCombineSubBpNode(i)));
        [indexRow,~] = ind2sub(size(neighborBp),locLink);
        if numel(indexRow)==1 % it has to be combined with another sub-bpNode
            neighborSinNode = pk_get_8nh_idx(bw1,toCombineSubBpNode(i));
            neighborIndex = intersect(toCombineSubBpNode,neighborSinNode);
            neighborIndex = neighborIndex(neighborIndex>0);
            edgeNum = edgeNum + 1;
            L(toCombineSubBpNode(i)) = edgeNum;
            L(neighborIndex) = edgeNum;
            toCombineSubBpNode(toCombineSubBpNode(i)) = 0;
            for k = 1:numel(neighborIndex)
                toCombineSubBpNode(toCombineSubBpNode==neighborIndex(k)) = 0;
            end
        elseif numel(indexRow)==2 % it is the middle of two nodes
            edgeNum = edgeNum + 1;
            L(toCombineSubBpNode(i)) = edgeNum;
            toCombineSubBpNode(toCombineSubBpNode(i)) = 0;
        end
    end
end

%to coonect the intersection nodes that are neighbors

edgeNumR = numel(unique(L))-1;
link = cell(1,edgeNumR);

index = 0;
for i = 1:edgeNum
    if ~isempty(find(L==i, 1))
        index = index + 1;
        link{index} = find(L==i);
        if numel(link{index})==1
            locLink = find(neighborBp==link{index});
        else
            [~,locLink] = ismember(link{index},neighborBp);%
        end
        [indexRow,~] = ind2sub(size(neighborBp),locLink(locLink>0));
        if numel(indexRow)==1
            indexRow = repmat(indexRow,1,2);% for isolate pixel
        end
        % some label is replaced
        link{index} = [node_intersect(indexRow(1));node_intersect(indexRow(2));link{index}];
    end
end

bwNodes = logical(bpImage+endpImage);
neighborNodes = pk_get_8nh_idx(bwNodes,node_intersect);
[row,~,v] = find(neighborNodes);
newLink = unique(sort([node_intersect(row),v],2),'rows');%if two nodes are neighbors, add a link

parfor i = 1:size(newLink,1)
    link{edgeNumR+i} = (newLink(i,:))';
end

parfor i = 1:edgeNumR
    % order the pixels in edge
    if numel(link{i}>3)
        temp = link{i};
        link{i}(1:2) = 0;
        for j=3:numel(link{i})
            neighborTemp = pk_get_8nh_idx(bw1,temp(j-1));
            [nextPixel,loc] = intersect(link{i},neighborTemp(neighborTemp>0));
            temp(j) = nextPixel(1);%the 85th edge is a circle
            link{i}(loc(1)) = 0;
        end
        link{i} = [temp(2);temp(3:end);temp(1)];
    end
end

link_xy = cell(numel(link),1);
link_length = zeros(numel(link),1);
edge = cell(numel(link),1);
for i = 1:numel(link)
    pixelLink(link{i}) = i;
    [rowP,colP] = ind2sub(size(bw),link{i});
    if numel(link{i})>2
        edgeTemp = DouglasPeucker([colP,rowP],2);%walk,small:10;chicago:2
        temp = edgeTemp(2:end,:);
        edge{i} = [edgeTemp(1:end-1,:),temp];
    else
        edge{i} = [colP(1),rowP(1),colP(2),rowP(2)];
    end
    link_xy{i} = edgeTemp*gridCellLength+repmat([xMin,yMin],size(edgeTemp,1),1);
    link_length(i) = sqrt((link_xy{i}(1,1)-link_xy{i}(end,1))^2+(link_xy{i}(1,2)-link_xy{i}(end,2))^2);
end
link_edge = cell(1,numel(link));
link_edge{1} = [1:size(edge{1},1)]';
index = size(edge{1},1);
for i = 2:numel(link)
    link_edge{i} = [index+1:index+size(edge{i},1)]';
    index = index + size(edge{i},1);
end
edge = cell2mat(edge)*gridCellLength+repmat([xMin,yMin],size(cell2mat(edge),1),2);
edge1 = edge';
edge2 = reshape(edge1,2,[]);
edge3 = edge2';
nodeA = unique(edge3,'rows');

edgeG = zeros(size(edge,1),4);
vertexG = [(1:size(nodeA,1))',nodeA];
for i = 1:size(edge,1)
    edgeG(i,1) = i;
    [~,~,edgeG(i,2)] = intersect([edge(i,1),edge(i,2)],vertexG(:,2:3),'rows');
    [~,~,edgeG(i,3)] = intersect([edge(i,3),edge(i,4)],vertexG(:,2:3),'rows');
end

