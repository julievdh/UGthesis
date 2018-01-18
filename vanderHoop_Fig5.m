clear all; close all

idn = '/Volumes/JULIE/EXTERNAL_DATA/THESIS/2003/JUNE/';
filename = 'jun15-30-2003-01.mat';
fid = [idn filename]
load(fid)

maxlat = 42.91;
minlat = 42.83;

 
sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2
minlong  = -65.4-longdeg/2

 
xtcklocs = [-65.45:0.02:-65.35];
ytcklocs = [42.83:0.01:42.91];

 
% xtcklabs =['65.45';'65.44';'65.43';'65.42';'65.41';'65.40';'65.39';'65.38';'65.37';'65.36';'65.35'];
xtcklabs =['65.45';'65.43';'65.41';'65.39';'65.37'];
ytcklabs =['42.83';'42.84';'42.85';'42.86';'42.87';'42.88';'42.89';'42.90'; '42.91'];

% USE LAT/LONG calculator to calculate 1km and set sc_bar_1 = dimensions
scbar_1 = [-65.450 42.835; -65.4379 42.835];


figure(1),
plot(posx1,posy1,'k')
set(gcf, 'Position',[100 100 800 800])
set(gcf, 'color', 'white');
hold on
axis([minlong maxlong minlat maxlat])

set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
xlabel('\circW Longitude ','fontsize',14)
ylabel('\circN Latitude ','fontsize',14)
set(gca,'fontsize',12)
% text(-66.4,43.95,'(a)','fontsize',14)
axis square

text(-65.448,42.838,'1 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
plot(scbar_1(:,1), scbar_1(:,2), 'k-', 'linewidth', 5)

print -r300 -dtiff vanderHoop_Figure4.tif
