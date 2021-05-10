clear
clc
close all;

%parameters
resampleInterval = 10; %distance between points for resample
cellLength = 3; %length of each pixel
sigma2 = 3;
epslon = 0.05;

TODO

% % resample trajectory to be equaldistance-interval
tic
trajSample = resampleTra(traj,resampleInterval);
% % obtian the density of trajectory
[xg,yg,density,trajGrid,codeOriginal] = obtainDensity(trajSample,cellLength);
Iblur = imgaussfilt(double(density)*3,5);

% % % % slide each trajectory
trajSlide = slide(Iblur,trajGrid,cellLength);
[densityNew,codeInd] = updateDensity(trajSlide,xg,yg,cellLength);

% % obtain density image
Iblur1 = imgaussfilt(double(densityNew)*3,sigma2);
Iblur2 = Iblur1>epslon;
Iblur2 = bwmorph(Iblur2,'fill','inf');
% %
% % %thinning - binary
bwout = bwmorph(Iblur2,'thin','inf');
bwout = bwmorph(bwout,'clean',1);
cc = bwconncomp(bwout);
bw = zeros(size(bwout));
bw(cc.PixelIdxList{1}) = 1;
[pixelLink,link,link_xy,link_length,edgeG,vertexG,link_edge] = thin2GraphLink(bw,xg(1),yg(1),cellLength);

[D,idx] = bwdist(bw);

% map trajectories into edges
total_code = dataToEdge(pixelLink,link,idx,codeInd);

[countE,elementC] = hist(total_code,1:numel(link));
flagToDisplay = filterWeiDouble(link,countE,link_length);
dispGraphLinkW(flagToDisplay,link_xy,countE);

edgeFlag = zeros(length(edgeG),1);
for i = 1:numel(link)
    if flagToDisplay(i)==0
        edgeFlag(link_edge{i}) = 1;
    end
end
temp = edgeG(edgeFlag==1,2:3);
verticesFlag = unique(temp(:));
edgeF = edgeG(edgeFlag==1,:);
vertexF = vertexG(verticesFlag,:);
toc
% % dispGraphLinkW(flagToDisplay,link_xy,countE);% uncomment to visualize the map
wf=('result/edges_athens_small.txt');
fileID = fopen(wf,'w');
for k=1:length(edgeF)
    fprintf(fileID,'%d,%d,%d,%d\n',edgeF(k,1),edgeF(k,2),edgeF(k,3),edgeF(k,4));
end
fclose(fileID);
wff=('result/vertices_athens_small.txt');
fileIDD = fopen(wff,'w');
for k=1:length(vertexF)
    fprintf(fileIDD,'%d,%f,%f\n',vertexF(k,1),vertexF(k,2),vertexF(k,3));
end
fclose(fileIDD);

