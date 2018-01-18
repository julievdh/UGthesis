close all; clear all; clc

idn = 'G:\Dalhousie\PhD_DATA\PhDwhales\2008DataRequest\SPUEdatabase\';
ifn = 'avanspu3.txt';
[year month lat long effort riwh_sig riwh_num riwh_SPUE huwh_sig huwh_num huwh_SPUE fiwh_sig fiwh_num fiwh_SPUE ...
    sewh_sig sewh_num sewh_SPUE miwh_sig miwh_num miwh_SPUE blwh_sig blwh_num blwh_SPUE spwh_sig spwh_num spwh_SPUE ...
    unba_sig unba_num unba_SPUE unfs_sig unfs_num unfs_SPUE unlw_sig unlw_num unlw_SPUE unmw_sig unmw_num unmw_SPUE ...
    unro_sig unro_num unro_SPUE unwh_sig unwh_num unwh_SPUE] = ...
    textread([idn ifn], '%n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n');


Effortdata_RIWH = [year month lat long effort riwh_sig riwh_num riwh_SPUE];
Effortdata_HUWH = [year month lat long effort huwh_sig huwh_num huwh_SPUE];
Effortdata_FIWH = [year month lat long effort fiwh_sig fiwh_num fiwh_SPUE];
Effortdata_SEWH = [year month lat long effort sewh_sig sewh_num sewh_SPUE];
Effortdata_MIWH = [year month lat long effort miwh_sig miwh_num miwh_SPUE];
Effortdata_BLWH = [year month lat long effort blwh_sig blwh_num blwh_SPUE];
Effortdata_SPWH = [year month lat long effort spwh_sig spwh_num spwh_SPUE];

clear huwh_sig huwh_num huwh_SPUE fiwh_sig fiwh_num fiwh_SPUE
clear sewh_sig sewh_num sewh_SPUE miwh_sig miwh_num miwh_SPUE blwh_sig blwh_num blwh_SPUE spwh_sig spwh_num spwh_SPUE
clear unba_sig unba_num unba_SPUE unfs_sig unfs_num unfs_SPUE unlw_sig unlw_num unlw_SPUE unmw_sig unmw_num unmw_SPUE
clear unro_sig unro_num unro_SPUE unwh_sig unwh_num unwh_SPUE
clear year month lat long effort riwh_sig riwh_num riwh_SPUE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Roseway and Bay of Fundy Study Areas

ii = find(Effortdata_RIWH(:,3)>42.5 & Effortdata_RIWH(:,3)< 43.5 & Effortdata_RIWH(:,4)<-64.75 & Effortdata_RIWH(:,4)>-66.0);
jj = find(Effortdata_RIWH(:,3)>44 & Effortdata_RIWH(:,3)< 45 & Effortdata_RIWH(:,4)<-66 & Effortdata_RIWH(:,4)>-67.0);

ROS_RIWH = Effortdata_RIWH(ii,:);
BOF_RIWH = Effortdata_RIWH(jj,:);


% for i = 1:12
% ii = find(BOF_RIWH(:,2)==i)
% Mon_effort(i) = sum(BOF_RIWH(ii,5));
% Mon_nums(i) = sum(BOF_RIWH(ii,7));
% Mon_SPUE(i) = (Mon_nums(i)/Mon_effort(i))*1000;
% end
% 
% figure(1),clf
% bar(Mon_SPUE)
% set(gca, 'tickdir','out')
% xlabel('Month')
% ylabel('SPUE')
% 
% for i = 1:12
% ii = find(ROS_RIWH(:,2)==i)
% Mon_effort(i) = sum(ROS_RIWH(ii,5));
% Mon_nums(i) = sum(ROS_RIWH(ii,7));
% Mon_SPUE(i) = (Mon_nums(i)/Mon_effort(i))*1000;
% end
% 
% figure(2),clf
% bar(Mon_SPUE)
% set(gca, 'tickdir','out')
% xlabel('Month')
% ylabel('SPUE')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(Gridcentres)
    jj = find(abs(ROS_RIWH(:,3)-latgrid(i))<=0.000000001 & abs(ROS_RIWH(:,4)-longgrid(i))<=0.000000001);
    dataind = isempty(jj);
    ROS_RIWH_AGG(i,1) = Gridcentres(i,1);
    ROS_RIWH_AGG(i,2) = Gridcentres(i,2);
    if dataind ==1
        ROS_RIWH_AGG(i,3) = 0;
        ROS_RIWH_AGG(i,4) = NaN;
        ROS_RIWH_AGG(i,5) = NaN;
        ROS_RIWH_AGG(i,6) = NaN;
    else ROS_RIWH_AGG(i,3) = nansum(ROS_RIWH(jj,5));
        ROS_RIWH_AGG(i,4) = nansum(ROS_RIWH(jj,6));
        ROS_RIWH_AGG(i,5) = nansum(ROS_RIWH(jj,7));
        ROS_RIWH_AGG(i,6) = (nansum(ROS_RIWH(jj,7))/nansum(ROS_RIWH(jj,5)))*1000;
  
    end
end

ROS_RIWH_AGG(393,6) = 128.41;


clear latgrid longgrid
lats = 42.50:0.05:43.45;
lats = lats';
longs =-64.75:-0.05:-65.95;
longs = longs';

latgrid = lats+.025;
longgrid = longs-.025;


for i = 1:length(latgrid)
    for j = 1:length(longgrid)
        jj = find(abs(ROS_RIWH_AGG(:,2)-latgrid(i))<=0.000000001 & abs(ROS_RIWH_AGG(:,1)-longgrid(j))<=0.000000001);
        dataind = isempty(jj);
        if dataind ==1
         ROS_RIWH_Grid(i,j) = NaN;
         
        else ROS_RIWH_Grid(i,j) = ROS_RIWH_AGG(jj,6);
            
        end

    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxlat = 44;
minlat = 42.4;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2
minlong  = -65.4-longdeg/2

coastdn = 'G:\Dalhousie\PhD_DATA\Coastline_data\';
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


figure(11),clf
map = Fishing_Fill;
new=join_cst(map,.0001);

figure(1),clf
set(gcf, 'Position',[100 100 800 800])
imagesc(longgrid,latgrid,ROS_RIWH_Grid)
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
plot(CA(:,1), CA(:,2), 'w--', 'linewidth',2)
plot(ATBA(:,1), ATBA(:,2), 'w-', 'linewidth',2)

axis([minlong maxlong minlat maxlat])
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
xlabel('^o Longitude')
ylabel('^o Latitude')
ylabel(H,'SPUE')
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lats = 44.00:0.05:44.95;
lats = lats';
lats = num2str(lats);
lats = str2num(lats);
longs =-66.0:-0.05:-66.95;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(Gridcentres)
    jj = find(abs(BOF_RIWH(:,3)-latgrid(i))<=0.000000001 & abs(BOF_RIWH(:,4)-longgrid(i))<=0.000000001);
    dataind = isempty(jj);
    BOF_RIWH_AGG(i,1) = Gridcentres(i,1);
    BOF_RIWH_AGG(i,2) = Gridcentres(i,2);
    if dataind ==1
        BOF_RIWH_AGG(i,3) = 0;
        BOF_RIWH_AGG(i,4) = NaN;
        BOF_RIWH_AGG(i,5) = NaN;
        BOF_RIWH_AGG(i,6) = NaN;
    else BOF_RIWH_AGG(i,3) = nansum(BOF_RIWH(jj,5));
        BOF_RIWH_AGG(i,4) = nansum(BOF_RIWH(jj,6));
        BOF_RIWH_AGG(i,5) = nansum(BOF_RIWH(jj,7));
        BOF_RIWH_AGG(i,6) = (nansum(BOF_RIWH(jj,7))/nansum(BOF_RIWH(jj,5)))*1000;
  
    end
end


clear latgrid longgrid
lats = 44.0:0.05:44.95;
lats = lats';
longs =-66.0:-0.05:-66.95;
longs = longs';

latgrid = lats+.025;
longgrid = longs-.025;


for i = 1:length(latgrid)
    for j = 1:length(longgrid)
        jj = find(abs(BOF_RIWH_AGG(:,2)-latgrid(i))<=0.000000001 & abs(BOF_RIWH_AGG(:,1)-longgrid(j))<=0.000000001);
        dataind = isempty(jj);
        if dataind ==1
         BOF_RIWH_Grid(i,j) = NaN;
         
        else BOF_RIWH_Grid(i,j) = BOF_RIWH_AGG(jj,6);
            
        end

    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minlat = 43.95;
maxlat = 45.05;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -66.5+longdeg/2
minlong  = -66.5-longdeg/2


CA = [-65.6667 43.0833;
-65.05 43.0833;
-65.05 42.75;
-65.6667 42.75;
-65.6667 43.0833];


figure(2),clf
set(gcf, 'Position',[100 100 800 800])
imagesc(longgrid,latgrid,BOF_RIWH_Grid)
H = colorbar
hold on

fillseg(new,[0.50196     0.50196     0.50196],[0 0 0]);
H1 =plot(Bathy_100m_contour(:,1),Bathy_100m_contour(:,2))
H2= plot(Bathy_200m_contour(:,1),Bathy_200m_contour(:,2))
H3 =plot(Bathy_500m_contour(:,1),Bathy_500m_contour(:,2))
H4= plot(Bathy_1000m_contour(:,1),Bathy_1000m_contour(:,2))
set(H2, 'color',[0.50196     0.50196     0.50196])
set(H1, 'color',[0.50196     0.50196     0.50196])
set(H3, 'color',[0.50196     0.50196     0.50196])
set(H4, 'color',[0.50196     0.50196     0.50196])
plot(CA(:,1), CA(:,2), 'w--', 'linewidth',2)
%plot(ATBA(:,1), ATBA(:,2), 'w-', 'linewidth',2)

axis([minlong maxlong minlat maxlat])
set(gca, 'tickdir','out')
set(gca, 'ydir', 'normal')
xlabel('^o Longitude')
ylabel('^o Latitude')
ylabel(H,'SPUE')
axis square

