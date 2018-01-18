% Quick log check
% plots the data for a visual check
% eventually puts in a log allowing to bring all the data together
 
 
 
idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/AIS_quicklogs/';
ifn ='2009-10-31_quicklog'

[day, month, year, hour, minute, second, TZ, MMSI, Status, ROT, Speed, PA, Latitude, Longitude, COG, Heading, UTC] ...
= textread([idn ifn], '%n %n %n %n %n %n %s %n %s %n %n %s %n %n %n %n %n', 'delimiter',','); %% reads in the data from the .tx2 file
AIS = [day, month, year, hour, minute, second, MMSI, Speed, Latitude, Longitude];

clear day month year hour minute second TZ MMSI Status ROT Speed PA Latitude Longitude COG Heading UTC


MMSI = AIS(:,7);
vess = unique(MMSI);

for i = 1:length(vess)
    ii = find(AIS(:,7)==vess(i));
    sepvess{i} = AIS(ii,:);
end

colours = rand(length(vess),3);

return


coastdn = 'C:\Documents and Settings\angelia\Desktop\AIS\';
coastfn = 'AIS_coast.dat';
load([coastdn coastfn])


CA = [-65.6667 43.0833;
-65.05 43.0833;
-65.05 42.75;
-65.6667 42.75;
-65.6667 43.0833];




% figure(1),clf
% for j = 1:length(vess)
%     H =plot(sepvess{j}(:,10).*-1, sepvess{j}(:,9), '.');
%     hold on
%     set(H, 'color', colours(j,:), 'markersize', 5)
%    end
% plot(AIS_coast(:,1).*-1,AIS_coast(:,2),'k')
% plot(CA(:,1).*-1, CA(:,2), 'k--', 'linewidth',2)
% axis([55 80 35 50])
% 
% set(gca, 'xdir', 'reverse')
% xlabel('^o W Longitude')
% ylabel('^o N Latitude')
% title([ifn(1:10)])





figure(2),clf
for j = 1:length(vess)
    H =plot(sepvess{j}(:,10).*-1, sepvess{j}(:,9), '.');
    hold on
    set(H, 'color', colours(j,:), 'markersize', 5)
    text(sepvess{j}(1,10)*-1, sepvess{j}(1,9),num2str(sepvess{j}(1,7)), 'color',colours(j,:))
end
plot(AIS_coast(:,1).*-1,AIS_coast(:,2),'k')
plot(CA(:,1).*-1, CA(:,2), 'k--', 'linewidth',2)
axis([63.5 67 41 45])

set(gca, 'xdir', 'reverse')
xlabel('^o W Longitude')
ylabel('^o N Latitude')
title([ifn(1:10)])



ATBA = [-64.9167 43.2667;  -64.9833 42.7833; -65.5167 42.65; -66.0833 42.8667; -64.9167 43.2667];
%%%%%%%%%%%%%%%%%%%
SA = [-66.25 42.5;
-64.5 42.5;
-64.5 43.5;
-66.25 43.5;
-66.25 42.5];

maxlat = 44.05;
minlat = 42.35;

sf_long = 1/(cos(((maxlat + minlat)/2)*(pi/180)));
latdeg = maxlat - minlat;
longdeg = sf_long*latdeg;
maxlong = -65.4+longdeg/2
minlong  = -65.4-longdeg/2
figure(4),clf
for j = 1:length(vess)
    H =plot(sepvess{j}(:,10).*-1, sepvess{j}(:,9), '.')
    hold on
    set(H, 'color', colours(j,:), 'markersize', 5);
end
plot(AIS_coast(:,1).*-1,AIS_coast(:,2),'k')
%plot(CA(:,1).*-1, CA(:,2), 'k--', 'linewidth',2)
plot(ATBA(:,1).*-1, ATBA(:,2), 'r-', 'linewidth',2)
axis([maxlong*-1 minlong*-1 minlat maxlat])
plot(SA(:,1).*-1, SA(:,2), 'k--', 'linewidth',2)
set(gca, 'xdir', 'reverse')
set(gca, 'tickdir','out')
xlabel('^oW Longitude')
ylabel('^oN Latitude')
%title([filelist{1}(1:10), ' to  ', filelist{end}(1:10)])
axis square
