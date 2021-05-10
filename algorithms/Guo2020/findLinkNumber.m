function codeToLink = findLinkNumber(pixelLink,link,idx,codeInd)
knn_loc = idx(codeInd);
codeToLink = pixelLink(knn_loc);
if numel(unique(codeToLink)) == 1
    number_link = numel(codeToLink);
    index_link = codeToLink(1);
else
    [number_link,index_link] = hist(codeToLink,unique(codeToLink));
end
for i = 1:numel(index_link)
    if number_link(i) < numel(link{index_link(i)})/2
        index_link(i) = 0;
    end
end
codeToLink = index_link(index_link>0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1:numel(knn_loc)
%     for j = 1:numel(link)
%         if ismember(knn_loc(i),link{j}) %%% try intersect
%             codeToLink(i) = j;
%             break;
%         end
%     end
% end

% codeUnique = codeToLink;
% codeDiff = diff(codeToLink);
% codeCount = find(codeDiff);
% codeUnique(codeDiff==0) = [];
% number = [codeCount;numel(codeToLink)] - [0;codeCount];
% delete some link
% 1)in which the number of pixels is less than 50% of this edge
% 2)connect the broken part with shorest path
% if numel(codeUnique)>2
%     flag = ones(size(codeUnique));
%     for i = 2:numel(codeUnique)-1
%         if number(i) < numel(link{codeUnique(i)})/2
%             flag(i) = 0;
%         end
%     end
%     codeUnique = codeUnique(flag==1);
%     codeUnique(diff(codeUnique)==0) = [];
%     codeUniqueTemp = codeUnique;
%
%     if numel(codeUniqueTemp)>2
%         if isempty(intersect(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1:2),...
%                 G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2)))%the beginning is broken
%             P = cell(4,1);
%             d = zeros(4,1);
%             edgepath = cell(4,1);
%             [P{1},d(1),edgepath{1}] = shortestpath(G,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1),G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1));
%             [P{2},d(2),edgepath{2}] = shortestpath(G,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1),G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),2));
%             [P{3},d(3),edgepath{3}] = shortestpath(G,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),2),G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1));
%             [P{4},d(4),edgepath{4}] = shortestpath(G,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),2),G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),2));
%             [~,index] = min(d);
%             codeUnique = [codeUnique;order.orderEdgeInLink(edgepath{index(1)})];
%             firstNode = P{index(1)}(end);
%             nextNode = setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2),firstNode);
%         else
%             firstNode = intersect(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1:2),...
%                 G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2));
%             %begin with a circle, cannot find the first node
%             if isequal(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1:2),G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2))
%                 nextNode = G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(1)),1);
%             else
%                 if isempty(setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2),firstNode))%if there is a circle
%                     nextNode = firstNode;
%                 else
%                     nextNode = setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(2)),1:2),firstNode);
%                 end
%             end
%         end
%         for j = 3:numel(codeUniqueTemp)
%             if isempty(intersect(nextNode,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1:2)))
%                 [P1,d1,edgepath1] = shortestpath(G,nextNode,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1));
%                 [P2,d2,edgepath2] = shortestpath(G,nextNode,G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),2));
%                 if isempty(P1)&&isempty(P2)
%                     break;
%                 else
%                     if d1<d2
%                         codeUnique = [codeUnique;order.orderEdgeInLink(edgepath1)];
%                         firstNode = P1(end);
%                         nextNode = setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1:2),firstNode);
%                     else
%                         codeUnique = [codeUnique;order.orderEdgeInLink(edgepath2)];
%                         firstNode = P2(end);
%                         nextNode = setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1:2),firstNode);
%                     end
%                 end
%             else
%                 if G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1) ~= G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),2)%the edge can be a circle
%                     nextNode = setdiff(G.Edges.EndNodes(order.orderLinkInEdge(codeUniqueTemp(j)),1:2),nextNode);
%                 end
%             end
%         end
%     end
% end
% codeToLink = codeUnique;
