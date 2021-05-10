function dispGraphLinkW(flag,linkxy,link_weight)

c = link_weight/max(link_weight(flag==0));
hold on
for i = 1:numel(linkxy)
    if flag(i)==0
        for j = 1:size(linkxy{i},1)-1
            patch('Faces',[1,2],'Vertices',[linkxy{i}(j,:);linkxy{i}(j+1,:)],'FaceVertexCData',[c(i);c(i)],...
                'EdgeColor','flat','FaceColor','none');
        end
    end
end
colorbar
axis xy;
axis off;
