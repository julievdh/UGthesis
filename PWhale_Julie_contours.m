clear all; clc

idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/';
ifn = 'ROS_SPUE.mat';

load([idn ifn])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


lats = 42.5:0.05:43.35;
lats = lats';
longs =-64.75:-0.05:-66.15;
longs = longs';

n = length(lats);
m = length(longs);

latgrid = lats+.025;
longgrid = longs-.025;




for i = 1:length(latgrid)
    for j = 1:length(longgrid)
        jj = find(abs(SPUE(:,2)-latgrid(i))<=0.0000001 & abs(SPUE(:,1)-longgrid(j))<=0.0000001);
        dataind = isempty(jj);
        if dataind ==1
            Pwhale_grid(i,j) = 0; % normally a NaN but replaced with zero for contouring;
        else Pwhale_grid(i,j)=SPUE(jj,7);
        end
        if isnan(Pwhale_grid(i,j))==1
            Pwhale_grid(i,j) = 0;
        end
    end
end

coastdn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/Coastline_Data/';
coastfn = 'Fishing_Fill.dat';
bathy100m = 'Bathy_100m_contour.dat';
bathy200m = 'Bathy_200m_contour.dat';
load([coastdn coastfn])
load([coastdn bathy100m])
load([coastdn bathy200m])

map = Fishing_Fill; 
new=join_cst(map,.0001);


CA = [-65.6667 43.0833;
-65.05 43.0833;
-65.05 42.75;
-65.6667 42.75;
-65.6667 43.0833];

% SA = [-66.0 42.5;
%     -64.75 42.5;
%     -64.75 43.5;
%     -66.0 43.5;
%     -66.0 42.5];

VD = [-66.1 42.6;
-64.8 42.6;
-64.8 43.3;
-66.1 43.3;
-66.1 42.6];


ATBA = [-64.9167 43.2667;  -64.9833 42.7833; -65.5167 42.65; -66.0833 42.8667; -64.9167 43.2667];

maxlat = 44;
minlat = 42.4;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.375+longdeg/2;
minlong  = -65.375-longdeg/2;

xtcklocs = [-66.4:0.2:-64.4];
ytcklocs = [42.4:.2:44];

scbar_25 = [-66.4 42.425; -66.095755 42.425];

xtcklabs =['66.4';'66.2';'66.0';'65.8';'65.6';'65.4';'65.2';'65.0';'64.8';'64.6';'64.4'];
ytcklabs =['42.4';'42.6';'42.8';'43.0';'43.2';'43.4';'43.6';'43.8'; '44.0'];
% figure(11),clf
% set(gcf, 'Position',[100 100 600 600])
% set(gcf, 'color', 'white');
% 
% imagesc(longgrid,latgrid, Pwhale_grid)
% hold on
% fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);
% H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2));
% H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2));
%         
% set(H2, 'color',[0.50196     0.50196     0.50196])
% set(H1, 'color',[0.50196     0.50196     0.50196])
% %set(H1, 'color', [0.8         0.8         0.8])
% %set(H2, 'color', [0.8         0.8         0.8])
% %plot(roseloc(:,1), roseloc(:,2), 'Marker','^','MarkerSize',8,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0.98039    0.019608     0.26275])
% 
% axis([minlong maxlong minlat maxlat])
% 
%         set(gca, 'tickdir','out')
%         set(gca, 'ydir', 'normal')
%         set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
%                 set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
% 
% plot(ATBA(:,1), ATBA(:,2), 'k-', 'linewidth',3)
% plot(VD(:,1), VD(:,2), 'k--', 'linewidth',3)
% xlabel('\circW Longitude ','fontsize',14)
% ylabel('\circN Latitude ','fontsize',14)
% set(gca,'fontsize',12)
%         axis square
%         
%         c = colorbar;
%         axes(c)
% ylabel('P(whale)','fontsize',14)
% set(gca,'fontsize',14)
% 

levels = 0:0.0005:0.05;
levels2 = [0; 0.00005; 0.0001; 0.005; 0.01; 0.015; 0.02;0.025; 0.03; 0.035; 0.040; 0.045];

figure(12),clf
set(gcf, 'Position',[100 100 800 800])
set(gcf, 'color', 'white');

contourf(longgrid,latgrid, Pwhale_grid, levels)
hold on
contour(longgrid,latgrid, Pwhale_grid, levels)
fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);

H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2));
H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2));
set(H1, 'color', [0.3     0.3     0.3])
set(H2, 'color', [0.78     0.78     0.78])


%set(H1, 'color', [0.8         0.8         0.8])
%set(H2, 'color', [0.8         0.8         0.8])
%plot(roseloc(:,1), roseloc(:,2), 'Marker','^','MarkerSize',8,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0.98039    0.019608     0.26275])

axis([minlong maxlong minlat maxlat])

        set(gca, 'tickdir','out')
        set(gca, 'ydir', 'normal')
        set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
                set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
        %xlabel('Longitude (decimal degrees)')
        %ylabel('Latitude (decimal degrees)')
        % plot(CA(:,1), CA(:,2), 'k--', 'linewidth',2)
text(-66.325,42.46,'25 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
text(-66.4,43.95,'(a)','fontsize',14,'fontweight','bold')
plot(scbar_25(:,1), scbar_25(:,2), 'k-', 'linewidth', 5)
        
plot(ATBA(:,1), ATBA(:,2), 'k-', 'linewidth',3)
plot(VD(:,1), VD(:,2), 'k--', 'linewidth',3)
xlabel('\circW Longitude ','fontsize',14)
ylabel('\circN Latitude ','fontsize',14)
set(gca,'fontsize',12)
        axis square
        
        c = colorbar;
        axes(c)
ylabel('P(whale)','fontsize',14)
set(gca,'fontsize',14)


print -r300 -dtiff vanderHoop_11-1841_Figure1a.tif

