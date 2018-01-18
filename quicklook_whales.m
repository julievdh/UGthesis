
cd /Users/julievanderhoop/Documents/MATLAB/UGthesis
[num,txt] = xlsread('Sightings_Tracker_Sheet.xlsx');   

%% data cleaning
% convert all longs to negative 
num(:,4) = -abs(num(:,4)); 
% select those within our time frame and region of interest
latlim = [45.5 50];
lonlim = [-66 -59];
num = num(find(iswithin(num(:,3),latlim)),:);
num = num(find(iswithin(num(:,4),lonlim)),:);
num = num(find(x2mdate(num(:,1)) < datenum([2017 8 15 0 0 0])),:); % keep dates before 15 Aug 2017

figure(1), clf, 
plot(num(:,4),num(:,3),'o')

GoSL_whales_fig

