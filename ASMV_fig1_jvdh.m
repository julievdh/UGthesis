CA = [-65.6667 43.0833;
-65.05 43.0833;
-65.05 42.75;
-65.6667 42.75;
-65.6667 43.0833];

 

 
ATBA = [-64.9167 43.2667;  -64.9833 42.7833; -65.5167 42.65; -66.0833 42.8667; -64.9167 43.2667];

%%%%%%%%%%%%%%%%%%%
SG = [-66.0 42.5;
    -64.75 42.5;
    -64.75 43.5;
    -66.0 43.5;
    -66.0 42.5];
VD = [-66.1 42.6;
-64.8 42.6;
-64.8 43.3;
-66.1 43.3;
-66.1 42.6];

 

coastdn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/Coastline_Data/';
% coastdn = '/Users/angeliavanderlaan/Documents/Dalhousie/PhD_DATA/Coastline_data/';
%coastdn = 'G:\Dalhousie\PhD_DATA\Coastline_data\';
coastfn = 'Fishing_Fill.dat';
% coastfn = 'VACATE_coast.dat';
bathy100m = 'Bathy_100m_contour.dat';
bathy200m = 'Bathy_200m_contour.dat';
load([coastdn coastfn])
load([coastdn bathy100m])
load([coastdn bathy200m])

figure(11),clf
map = Fishing_Fill; 
% map = VACATE_coast;
new=join_cst(map,.0001);

 
Recloc = [-65.6318 43.5837];
maxlat = 44;
minlat = 42.4;

 
sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.375+longdeg/2;
minlong  = -65.375-longdeg/2;

 

 
xtcklocs = [-66.4:0.2:-64.4];
ytcklocs = [42.4:.2:44];

 
xtcklabs =['66.4';'66.2';'66.0';'65.8';'65.6';'65.4';'65.2';'65.0';'64.8';'64.6';'64.4'];
ytcklabs =['42.4';'42.6';'42.8';'43.0';'43.2';'43.4';'43.6';'43.8'; '44.0'];

 
%xtcklabs = ['66.0';'65.5';'65.0';'64.5'];
%ytcklabs = ['42.5';'43.0';'43.5';'44.0'];

 
sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2;
minlong  = -65.4-longdeg/2;

 
scbar_10 = [-66.4 42.425; -66.2783 42.425];
scbar_50 = [-66.4 42.425; -65.79152 42.425];
scbar_25 = [-66.4 42.425; -66.095755 42.425];

 
roseloc = [-65.6318 43.5837];

%%  

figure(1),
set(gcf, 'Position',[100 100 800 800])
set(gcf, 'color', 'white');
hold on
% for j = 1:length(vess)
%     H =plot(sepvess{j}(:,10), sepvess{j}(:,9), '.')
%     hold on
%     set(H, 'color', colours(j,:), 'markersize', 2);
% end
fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);

 
H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2))
H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2))
set(H2, 'color', [0.31373     0.31765     0.31373])
set(H1, 'color', [0.31373     0.31765     0.31373])
% 
%plot(SG(:,1), SG(:,2), '--', 'linewidth',2, 'color',[1           0         0.6]);
%plot(CA(:,1), CA(:,2), 'k--', 'linewidth',2)
%text(-66.175,42.46,'50 km','fontsize',10, 'backgroundcolor', 'w')
text(-66.325,42.46,'25 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
plot(scbar_25(:,1), scbar_25(:,2), 'k-', 'linewidth', 5)
plot(VD(:,1), VD(:,2), 'k--', 'linewidth',3)
plot(ATBA(:,1), ATBA(:,2), 'k-', 'linewidth',3)
%plot(roseloc(:,1), roseloc(:,2), 'Marker','^','MarkerSize',6,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0])

 
axis([minlong maxlong minlat maxlat])

 
%set(gca, 'xdir', 'reverse')
set(gca, 'tickdir','out')

 
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
xlabel('^oW Longitude ','fontsize',14)
ylabel('^oN Latitude ','fontsize',14)
set(gca,'fontsize',12)
% text(-66.4,43.95,'(a)','fontsize',14)
axis square
box on

% print -dtiffnocompression vanderHoop_Figure1.tif

