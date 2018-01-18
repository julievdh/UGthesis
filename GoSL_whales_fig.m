%% get coastline data 
coastdn = '/Users/julievanderhoop/Documents/MATLAB/UGthesis/Coastline_Data/';
% coastdn = '/Users/angeliavanderlaan/Documents/Dalhousie/PhD_DATA/Coastline_data/';
% coastdn = 'G:\Dalhousie\PhD_DATA\Coastline_data\';
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
%% 
 
maxlat = max(latlim);
minlat = min(latlim);

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -63.375+longdeg/2;
minlong  = -63.375-longdeg/2;
 
%xtcklocs = [-66.4:0.2:-64.4];
%ytcklocs = [42.4:.2:44];
 
%xtcklabs =['66.4';'66.2';'66.0';'65.8';'65.6';'65.4';'65.2';'65.0';'64.8';'64.6';'64.4'];
%ytcklabs =['42.4';'42.6';'42.8';'43.0';'43.2';'43.4';'43.6';'43.8'; '44.0'];

 
scbar_10 = [-66.4 42.425; -66.2783 42.425];
scbar_50 = [-66.4 42.425; -65.79152 42.425];
scbar_25 = [-66.4 42.425; -66.095755 42.425];

%%  

figure(1),
set(gcf, 'Position',[100 100 800 800])
set(gcf, 'color', 'white');
hold on
fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);

 
H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2))
H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2))
set(H2, 'color', [0.31373     0.31765     0.31373])
set(H1, 'color', [0.31373     0.31765     0.31373])
% text(-66.325,42.46,'25 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
% plot(scbar_25(:,1), scbar_25(:,2), 'k-', 'linewidth', 5)
 
axis([minlong maxlong minlat maxlat])

 
%set(gca, 'xdir', 'reverse')
set(gca, 'tickdir','out')

 
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
%set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
%set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
xlabel('^oW Longitude ','fontsize',14)
ylabel('^oN Latitude ','fontsize',14)
set(gca,'fontsize',12)
% text(-66.4,43.95,'(a)','fontsize',14)
axis square
box on

