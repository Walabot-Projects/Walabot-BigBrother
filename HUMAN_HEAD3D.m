function [] = HUMAN_HEAD3D()
% Display the human head graphics


filename='human-head.stl';
[p,t,tnorm]=STL_Import(filename);
 
trisurf(t,p(:,1),p(:,2),p(:,3),'FaceColor',[0.5 0.5 0.5],'EdgeAlpha',0);

set(gcf,'units','normalized','outerposition',[0 0 1 1])
box off;
axis('vis3d');
axis image;
set(gca,'xcolor','w','ycolor','w','zcolor','w','xtick',[],'ytick',[],'ztick',[]);
set(gcf, 'color', [1 1 1])
camlight;
box off;


end