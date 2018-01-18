maxlat = 44;
minlat = 42.4;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2;
minlong  = -65.4-longdeg/2;

coastdn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/Coastline_Data/';
coastfn = 'Fishing_Fill.dat';
bathy100m = 'Bathy_100m_contour.dat';
bathy200m = 'Bathy_200m_contour.dat';
bathy500m = 'Bathy_500m_contour.dat';
bathy1000m = 'Bathy_1000m_contour.dat';
hagueline = 'Hagueline_greyzone.dat';

load([coastdn coastfn])
load([coastdn bathy100m])
load([coastdn bathy200m])
load([coastdn bathy500m])
load([coastdn bathy1000m])
load([coastdn hagueline])

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

figure(11),clf
map = Fishing_Fill;
new=join_cst(map,.0001);

figure(1),clf
set(gcf, 'Position',[100 100 800 800])
% imagesc(longgrid,latgrid,Whale_count)
H = colorbar
hold on
plot(Hagueline_greyzone(:,1),Hagueline_greyzone(:,2),'w')
fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);
H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2))
H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2))
H3 =plot(Bathy_500m_contour(:,1),Bathy_500m_contour(:,2))
H4= plot(Bathy_1000m_contour(:,1),Bathy_1000m_contour(:,2))
set(H2, 'color',[0.50196     0.50196     0.50196])
set(H1, 'color',[0.50196     0.50196     0.50196])
set(H3, 'color',[0.50196     0.50196     0.50196])
set(H4, 'color',[0.50196     0.50196     0.50196])
plot(CA(:,1), CA(:,2), 'r--', 'linewidth',2)
plot(ATBA(:,1), ATBA(:,2), 'r-', 'linewidth',2)

axis([minlong maxlong minlat maxlat])
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
xlabel('^oN Longitude')
ylabel('^oW Latitude')
ylabel(H,'SPUE')
axis square