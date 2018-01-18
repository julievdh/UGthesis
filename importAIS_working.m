%%Moves ship in certain direction from initial spot at whatever speed
%%desired, over desired amount of steps.

close all; clear all; clc

AIS = [0 0 0 0 0 0 0 0 0 0];

% import batch of quicklog files over specified bi-weekly period
idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/AIS_quicklogs/';
filename = 'quicklogs_ROS2008-09-01-09-15.list';
filelist = rd_list([idn filename]);

% set up vector of AIS data: day month year hour minute second MMSI speed
% lat and lon of all transmissions received within bi-weekly period
for i = 1:length(filelist)
    ifn  = filelist{i};
    
    [day, month, year, hour, minute, second, TZ, MMSI, Status, ROT, Speed, PA, Latitude, Longitude, COG, Heading, UTC] ...
        = textread([idn ifn], '%n %n %n %n %n %n %s %n %s %n %n %s %n %n %n %n %n', 'delimiter',','); %% reads in the data from the .tx2 file
    useful_AIS = [day, month, year, hour, minute, second, MMSI, Speed, Latitude, Longitude];
    
    AIS = [AIS; useful_AIS];
    
    clear day month year hour minute second TZ MMSI Status ROT Speed PA Latitude Longitude COG Heading UTC useful_AIS
end

% clear first line of zeros
AIS = AIS(2:end,:);

% calculate datenum for transmission reception date and time
for i = 1:length(AIS)
    AIS(i,11) = datenum([(AIS(i,3)+2000),AIS(i,2),AIS(i,1),AIS(i,4),AIS(i,5),AIS(i,6)]);
end

% sort matrix by transmission reception time
AIS = sortrows(AIS,11);

% load vessel size data from slowlog data
% remove vessels with with MMSI <200000000 as are not IMO registered
load('sizevess_ROS.mat')
ii = find(sizevess_ROS(:,1) >= 200000000);
sizevess_ROS = sizevess_ROS(ii,:);

% find transmission receptions within study area (42.5 - 43.5 N and 66.25 -64.75 W)
ii = find(AIS(:,9)>42.5 & AIS(:,9)< 43.5 & AIS(:,10)<-64.75 & AIS(:,10)>-66.25);
AIS = AIS(ii,:);

% set up unique MMSI vector with unique colours used in plotting
MMSI = AIS(:,7);
vess = unique(MMSI);
colours = rand(length(vess),3);

% set up sepvess cell array: separates all unique vessels and organizes all
% transits of unique vessel in single matrix
counter = 0;
for i = 1:length(vess)
    ii = find(AIS(:,7) == vess(i));
    ind = size((ii),1);
    if ind > 0
        counter = counter + 1;
        sepvess{counter} = AIS(ii,:);
    else counter = counter;
        clear ind
    end
end

% re-check: sort each sepvess transmission reception record by time
for i = 1:length(sepvess)
    sepvess{i} = sortrows(sepvess{i},11);
end

% convert any speeds >40 knots to NaN - likely to be errors.
for i = 1:length(sepvess)
    ii = find(sepvess{i}(:,8) > 40);
    sepvess{i}(ii,8) = NaN;
end

% quick check to see where the data is; plots each vessel in separate
% colour
for j = 1:length(vess);
    H = plot(sepvess{j}(:,10), sepvess{j}(:,9), 'k.');
    hold on
    set(H, 'color', colours(j,:), 'markersize', 3)
end

% set up vector ship, with information of all ships with transmission
% receptions over bi-weekly period

% ship is [n vessels x 20] with columns of [MMSI, speed, lon of first
% entry into domain, lat of first entry into domain, lon of exit
% from domain, lat of exit from domain, 7, 8, 9, 10, 11, 12, 13, 14,
% datenum of entry into domain, 16, 17, 18, 19, datenum of exit from
% domain]
for i = 1:length(sepvess)
    ship(i,1) = sepvess{i}(1,7);
    ship(i,2) = nanmean(sepvess{i}(:,8));
    ship(i,3) = sepvess{i}(1,10);
    ship(i,4) = sepvess{i}(1,9);
    ship(i,5) = sepvess{i}(end,10);
    ship(i,6) = sepvess{i}(end,9);
    ship(i,15) = sepvess{i}(1,11);
    ship(i,20) = datenum(sepvess{i}(end,3)+2000,sepvess{i}(end,2),sepvess{i}(end,1),sepvess{i}(end,4),sepvess{i}(end,5),sepvess{i}(end,6));
end

% sort ship by datenum of entry into domain
ship = sortrows(ship,15);

% check and only be sure vessels > 200000000
ii = find(ship(:,1) >= 200000000);
ship = ship(ii,:);

% time of first entry of each unique vessel
for i = 1:size(sepvess{1,1},2)
    time(i) = sepvess{1,i}(1,1);
    for j = 1:length(sepvess)
        time(j,i) = sepvess{1,j}(1,i);
    end
end

% find length/width values from sizevess matrix indexed by MMSI. If lacking
% information, width and length = median values.
for i = 1:length(ship)
    ii = find(ship(i,1) == sizevess_ROS(:,1));
    ind_ii = size(ii,1);
    if ind_ii == 0
        ship(i,7) = 184; % median length
        ship(i,8) = 31; % median width
    else ship(i,7) = sizevess_ROS(ii(1),4);
        ship(i,8) = sizevess_ROS(ii(1),5);
    end
end

% % % % % % % % % % % % % % % % % % % % % % % % % set starting point of ships
% % % % % % % % % % % % % % % % % % % % % % % % shipx = ship(1,3);
% % % % % % % % % % % % % % % % % % % % % % % % shipy = ship(1,4);


% determine ship heading
for i = 1:length(ship)
    % calculate delta northing (nautical miles)
    ship(i,10) = (ship(i,4) - ship(i,6))*-60;
    % calculate delta easting (nautical miles)
    deleast(1,i) = ship(i,4);
    deleast(2,i) = ship(i,6);
    for j = 1:size(deleast,1)
        deleast(3,i) = (deleast(1,i)+deleast(2,i))/2;
    end
    
    ship(i,9) = (ship(i,3)-ship(i,5))*-60*cos((deleast(3,i)*(1/57.295779513)));
    
    for i = 1:length(ship)
        if ship(i,9) >= 0
            ship(i,11) = atan2(ship(i,9),ship(i,10))*180/pi;
        else ship(i,11) = atan2(ship(i,9),ship(i,10))*180/pi+360;
        end
    end
    
    % calculate delta easting/northing in degrees
    for i = 1:length(ship)
        ship(i,12) = ship(i,5)-ship(i,3);
        ship(i,13) = ship(i,6)-ship(i,4);
        % greater circle distance in m
        ship(i,14) = acos(sin(ship(i,4)/57.295779513)*sin(ship(i,6)/57.295779513)+cos(ship(i,4)/57.295779513)*cos(ship(i,6)/57.295779513)*cos((ship(i,3)-ship(i,5))/57.295779513))*6378.139*1000;
    end
end

%%%% CHECK TO SEE IF THIS IS USED
for i=1:length(ship);
    time(i,7)=ship(i,1);
    time(i,8)=ship(i,2);
    time(i,12)=etime(datevec(ship(i,20)),datevec(ship(i,15)));
    time(i,13)=time(i,12)/3.5;
end
time=sortrows(time,12);

% determine number of steps required to transit area
for i = 1:length(ship)
    % distance divided by ship speed (converted to m/s) /step
    stepdist(i,1) = ship(i,14)/(ship(i,2)*1.852*0.2777778)/3.5;
    stepdist(i,5) = ship(i,15); % datenum of entry
    stepdist(i,4) = ship(i,1); % ship MMSI
    % determine distance per step in east and north directions
    stepdist(i,2) = ship(i,12)/stepdist(i,1);
    stepdist(i,3) = ship(i,13)/stepdist(i,1);
    ship(i,17) = stepdist(i,1);
    ship(i,18) = stepdist(i,2);
    ship(i,19) = stepdist(i,3);
end
stepdist=sortrows(stepdist,5);

% i know that this is in here twice, but it's the only way to make
% time/etime, etc work. 
for i=1:length(ship);
    time(i,7)=ship(i,1);
    time(i,8)=ship(i,2);
    time(i,12)=etime(datevec(ship(i,20)),datevec(ship(i,15)));;
    time(i,13)=time(i,12)/3.5;
    ship(i,21)=time(i,13);
end
time=sortrows(time,12);
ii=find(ship(:,21)>=0);
ship=ship(ii,:);
ii=find(time(:,13)>=0);
time=time(ii,:);

for i = 1:length(ship);
    ship(i,16) = time(i,13) + stepdist(i,1);
end
