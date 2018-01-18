% plots vessel tracks for a given selection 

close all; clear all; clc

AIS = [0 0 0 0 0 0 0 0 0 0];

idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/AIS_quicklogs/';
filename = 'quicklogs_ROS2009.list';
filelist = rd_list([idn filename]);

for i = 1:length(filelist)
  ifn  = filelist{i};

  [day, month, year, hour, minute, second, TZ, MMSI, Status, ROT, Speed, PA, Latitude, Longitude, COG, Heading, UTC] ...
      = textread([idn ifn], '%n %n %n %n %n %n %s %n %s %n %n %s %n %n %n %n %n', 'delimiter',','); %% reads in the data from the .tx2 file
  useful_AIS = [day, month, year, hour, minute, second, MMSI, Speed, Latitude, Longitude];

  AIS = [AIS; useful_AIS];

  clear day month year hour minute second TZ MMSI Status ROT Speed PA Latitude Longitude COG Heading UTC useful_AIS
end

AIS = AIS(2:end,:);
for i=1:length(AIS)
    AIS(i,11)=datenum([(AIS(i,3)+2000),AIS(i,2),AIS(i,1),AIS(i,4),AIS(i,5),AIS(i,6)]);
end
AIS=sortrows(AIS,11);

% cuts out data with MMSI<200000000 as are not IMO registered.
load('sizevess_ROS.mat')
ii=find(sizevess_ROS(:,1)>=200000000);
sizevess_ROS=sizevess_ROS(ii,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxlat = 44;
minlat = 42.4;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2;
minlong  = -65.4-longdeg/2;

ii = find(AIS(:,9)>minlat & AIS(:,9)< maxlat & AIS(:,10)<maxlong & AIS(:,10)>minlong);
AIS = AIS(ii,:);
MMSI = AIS(:,7);  % could move this below line 43 earier method to fix the problem.
vess = unique(MMSI);
colours = rand(length(vess),3);

counter = 0;
for i = 1:length(vess)
    ii = find(AIS(:,7)==vess(i));
    ind = size((ii),1);
    if ind > 0 
        counter = counter +1;
    sepvess{counter} = AIS(ii,:);
    else counter = counter;
        clear ind
    end
end

for i=1:length(sepvess)
    sepvess{i}=sortrows(sepvess{i},11);
end

% converts any speeds >40 knots to NaN - likely to be errors.
for i = 1:length(sepvess)
   ii = find(sepvess{i}(:,8)>40);
   sepvess{i}(ii,8)=NaN;
end

% Quick check to see where the data is
for j=1:length(vess);
H =plot(sepvess{j}(:,10), sepvess{j}(:,9), 'k.');
hold on
set(H, 'color', colours(j,:), 'markersize', 3)
end
% yay its where you selected



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

figure(1),
set(gcf, 'Position',[100 100 400 400])
% imagesc(longgrid,latgrid,Whale_count)
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
plot(CA(:,1), CA(:,2), 'r--', 'linewidth',3)
plot(ATBA(:,1), ATBA(:,2), 'r-', 'linewidth',3)

axis([minlong maxlong minlat maxlat])
set(gca, 'tickdir','out','fontsize',14)
set(gca, 'ydir', 'normal','fontsize',14)
xlabel('^oW Longitude','fontsize',13)
ylabel('^oN Latitude','fontsize',13)
title('2009')
axis square