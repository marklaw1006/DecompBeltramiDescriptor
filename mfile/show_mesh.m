function show_mesh(v,f,arg3)
% Plot a mesh.
% 
% Input: 
% v: nv x 3 vertex coordinates
% f: nf x 3 triangulations
% arg3 (optional): nv x 1 quantity defined on vertices
% 
% If you use this code in your own work, please cite the following paper:
% [1] G. P. T. Choi, H. L. Chan, R. Yong, S. Ranjitkar, A. Brook, G. Townsend, K. Chen, and L. M. Lui, 
%     "Tooth morphometry using quasi-conformal theory."
%     ArXiv:1901.01651, 2019.
%
% Copyright (c) 2019, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

if nargin < 3
    graph = figure; patch('Faces',f,'Vertices',v,'FaceColor','none',...
        'EdgeColor',[64,150,190]/255,'LineWidth',0.5);
else
    graph = figure; patch('Faces',f,'Vertices',v,'FaceColor','flat','FaceVertexCData',arg3,...
        'EdgeColor','k', 'LineWidth',0.1);
    colormap jet; 
    colorbar
end

axis equal tight

ax = gca;               % get the current axis
ax.Clipping = 'off';    % turn clipping off

end
