maxlat = 43.5;
minlat = 42.4;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2;
minlong  = -65.4-longdeg/2;

CA = [-65.6667 43.0833;
-65.05 43.0833;
-65.05 42.75;
-65.6667 42.75;
-65.6667 43.0833];


ATBA = [-64.9167 43.2667;  -64.9833 42.7833; -65.5167 42.65; -66.0833 42.8667; -64.9167 43.2667];

lats = 42.50:0.05:43.45;
lats = lats';
lats = num2str(lats);
lats = str2num(lats);
longs =-64.750:-0.05:-65.95;
longs = longs';
longs = num2str(longs);
longs = str2num(longs);
n = length(lats);
m = length(longs);

latc = lats+.025;
longc = longs-.025;


longgrid = repmat(longc,[n,1]);
latgrid = repmat(latc, [m,1]);
longgrid = sort(longgrid,1);

Gridcentres = [longgrid latgrid];

hold on
plot(CA(:,1), CA(:,2), 'r--', 'linewidth',2)
plot(ATBA(:,1), ATBA(:,2), 'r-', 'linewidth',2)

axis([minlong maxlong minlat maxlat])
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
axis square