function nhood = pk_get_8nh_idx(img,i)
rowN = size(img,1);
%neighbors of left,up,right,down,leftup,rightup,rightdown,leftdown
nhood = [i-rowN;i-1;i+rowN;i+1;i-rowN-1;i+rowN-1;i+rowN+1;i-rowN+1];
nhood = reshape(nhood,numel(i),8);
loc = ~img(nhood);
nhood(loc) = 0;
