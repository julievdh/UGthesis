clear all; close all

% CRW code for whatever number of steps (i =, below)
% x = -65.00;
% y = 42.90;
% n = 1;
% 
% dir=unifrnd(-pi,pi,1,n);
% dis=unifrnd(0,0.00003867,1,n);
% for    i=1:754; % length of time (1029 steps = 1hr)
%     for j=1:length(x)
%         x(j) = x(j)+(cos(dir(j))*dis(j));
%         y(j) = y(j)+(sin(dir(j))*dis(j));
%         positionx(i,:) = x;
%         positiony(i,:) = y;
%     end
%     dir=dir+unifrnd(-0.1854,0.1854,1,n);
%     dis=unifrnd(0,0.00003867,1,n);
% end
% 
% plot(positionx(:,j),positiony(:,j))


load('Fig6_44min_positions.mat')

plot(positionx,positiony,'k')

maxlat = 42.852;
minlat = 42.845;


sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -64.9395+longdeg/2
minlong  = -64.9395-longdeg/2


xtcklocs = [-64.9443:0.002:-64.9347];
ytcklocs = [42.845:0.001:42.852];

xtcklabs =['64.9443';'64.9423';'64.9403';'64.9383';'64.9363'];
ytcklabs =['42.845';'42.846';'42.847';'42.848';'42.849';'42.850';'42.851';'42.852'];

% USE LAT/LONG calculator to calculate 1km and set sc_bar_1 = dimensions
scbar_100m = [-64.943 42.8455; -64.94207 42.8455];


figure(1),
plot(positionx,positiony,'k')
set(gcf, 'Position',[100 100 800 800])
set(gcf, 'color', 'white');
hold on
axis([minlong maxlong minlat maxlat])

set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
xlabel('^oW Longitude ','fontsize',14)
ylabel('^oN Latitude ','fontsize',14)
set(gca,'fontsize',12)
% text(-66.4,43.95,'(a)','fontsize',14)
axis square

text(-64.9428,42.8457,'100 m','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
plot(scbar_100m(:,1), scbar_100m(:,2), 'k-', 'linewidth', 5)

print -dtiffnocompression vanderHoop_Figure5_44min.tif
