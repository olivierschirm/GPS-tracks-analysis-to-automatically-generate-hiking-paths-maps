function total_code = dataToEdge(pixelLink,link,idx,codeInd)
link_code = cell(1,numel(codeInd));% for each trajectory
parfor i = 1:numel(codeInd)
    link_code{i} = findLinkNumber(pixelLink,link,idx,codeInd{i});
end
newCode = link_code(~cellfun('isempty',link_code));
total_code = cat(1,newCode{:});
