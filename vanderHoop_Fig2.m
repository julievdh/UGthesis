%%Plots coastline and vessels for a given year or portion of years (Figure
%%2 (a,b,c) in manuscript

close all; clear all; clc

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
new=join_cst(map,.0001);

 
Recloc = [-65.6318 43.5837];
maxlat = 44;
minlat = 42.4;

 
sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.375+longdeg/2
minlong  = -65.375-longdeg/2

 

 
xtcklocs = [-66.4:0.2:-64.4];
ytcklocs = [42.4:.2:44];

 
xtcklabs =['66.4';'66.2';'66.0';'65.8';'65.6';'65.4';'65.2';'65.0';'64.8';'64.6';'64.4'];
ytcklabs =['42.4';'42.6';'42.8';'43.0';'43.2';'43.4';'43.6';'43.8'; '44.0'];

 
%xtcklabs = ['66.0';'65.5';'65.0';'64.5'];
%ytcklabs = ['42.5';'43.0';'43.5';'44.0'];

 
sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2
minlong  = -65.4-longdeg/2

 
scbar_10 = [-66.4 42.425; -66.2783 42.425];
scbar_50 = [-66.4 42.425; -65.79152 42.425];
scbar_25 = [-66.4 42.425; -66.095755 42.425];

 
roseloc = [-65.6318 43.5837];

 

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
axis([minlong maxlong minlat maxlat])

 
%set(gca, 'xdir', 'reverse')
set(gca, 'tickdir','out')

 
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
set(gca, 'xtick', xtcklocs, 'xticklabel', xtcklabs)
set(gca, 'ytick', ytcklocs, 'yticklabel', ytcklabs)
xlabel('\circW Longitude ','fontsize',14)
ylabel('\circN Latitude ','fontsize',14)
set(gca,'fontsize',12)
axis square

AIS = [0 0 0 0 0 0 0 0 0 0];

idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/AIS_quicklogs/';
filename = 'quicklogs_ROS2007.list';
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

% ii = find(AIS(:,9)>42.5 & AIS(:,9)< 43.5 & AIS(:,10)<-64.75 & AIS(:,10)>-66.25);
% AIS = AIS(ii,:);
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
set(H, 'color', colours(j,:), 'markersize', 5)
end
% yay its where you selected

text(-66.325,42.46,'25 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
plot(scbar_25(:,1), scbar_25(:,2), 'k-', 'linewidth', 5)
plot(VD(:,1), VD(:,2), 'k--', 'linewidth',3)
plot(ATBA(:,1), ATBA(:,2), 'k-', 'linewidth',3)
text(-66.4,43.95,'(a)','fontsize',14)
box on

print -r300 -dtiff vanderHoop_Figure2a.tif