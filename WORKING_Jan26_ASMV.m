%%Moves ship in certain direction from initial spot at whatever speed
%%desired, over desired amount of steps.

close all; clear all; clc

AIS = [0 0 0 0 0 0 0 0 0 0];

% import batch of quicklog files over specified bi-weekly period
idn = '/Users/julievanderhoop/Documents/MATLAB/Thesis/AIS_quicklogs/';
filename = 'quicklogs_ROS2008-09-01-09-15.list';
filelist = rd_list([idn filename]);

% set up vector of AIS data: day month year hour minute second MMSI speed
% lat and lon of all receptions within bi-weekly period
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

% calculate datenum for reception date and time
for i = 1:length(AIS)
    AIS(i,11) = datenum([(AIS(i,3)+2000),AIS(i,2),AIS(i,1),AIS(i,4),AIS(i,5),AIS(i,6)]);
end

% sort matrix by reception time
AIS = sortrows(AIS,11);

% cuts out data with MMSI<200000000 as are not IMO registered.
load('sizevess_ROS.mat')
ii=find(sizevess_ROS(:,1)>=200000000);
sizevess_ROS=sizevess_ROS(ii,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ii = find(AIS(:,9)>42.5 & AIS(:,9)< 43.5 & AIS(:,10)<-64.75 & AIS(:,10)>-66.25);
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


for i = 1:length(sepvess)
    ship(i,1) = sepvess{i}(1,7);
    ship(i,2) = nanmean(sepvess{i}(:,8));
    ship(i,3) = sepvess{i}(1,10);
    ship(i,4) = sepvess{i}(1,9);
    ship(i,5) = sepvess{i}(end,10);
    ship(i,6) = sepvess{i}(end,9);
    ship(i,15) = sepvess{i}(1,11);
    ship(i,20)=datenum(sepvess{i}(end,3)+2000,sepvess{i}(end,2),sepvess{i}(end,1),sepvess{i}(end,4),sepvess{i}(end,5),sepvess{i}(end,6));
end
ship=sortrows(ship,15);
ii=find(ship(:,1)>=200000000);
ship=ship(ii,:);

for i=1:size(sepvess{1,1},2)
    time(i)=sepvess{1,i}(1,1);
    for j=1:length(sepvess)
        time(j,i)=sepvess{1,j}(1,i);
    end
end


%%gets length/width values from sizevess indexed by MMSI. If lacking
%%information, width and length = median values.
for i = 1:length(ship)
    ii = find(ship(i,1) == sizevess_ROS(:,1));
    ind_ii=size(ii,1);
    if ind_ii==0
        ship(i,7)=184;
        ship(i,8)=31;
    else ship(i,7)=sizevess_ROS(ii(1),4);
        ship(i,8)=sizevess_ROS(ii(1),5);
    end   
end
% 


% sets starting point of ships
shipx=ship(1,3);
shipy=ship(1,4);
% determines ship heading
for i=1:length(ship)
    ship(i,10)=(ship(i,4)-ship(i,6))*-60;
    %%delta northing (in nautical miles)
    deleast(1,i)=ship(i,4);
    deleast(2,i)=ship(i,6);
    for j=1:size(deleast,1)
        deleast(3,i)=(deleast(1,i)+deleast(2,i))/2;
    end
    ship(i,9)=(ship(i,3)-ship(i,5))*-60*cos((deleast(3,i)*(1/57.295779513)));
    %%delta easting (in nautical miles)
    for i=1:length(ship)
        if ship(i,9)>=0
            ship(i,11)=atan2(ship(i,9),ship(i,10))*180/pi;
        else ship(i,11)=atan2(ship(i,9),ship(i,10))*180/pi+360;
        end
    end
    % delta easting/northing in degrees
    for i=1:length(ship)
        ship(i,12)=ship(i,5)-ship(i,3);
        ship(i,13)=ship(i,6)-ship(i,4);
        % greater circle distance in m
        ship(i,14)=acos(sin(ship(i,4)/57.295779513)*sin(ship(i,6)/57.295779513)+cos(ship(i,4)/57.295779513)*cos(ship(i,6)/57.295779513)*cos((ship(i,3)-ship(i,5))/57.295779513))*6378.139*1000;
    end
end

for i=1:length(ship);
    time(i,7)=ship(i,1);
    time(i,8)=ship(i,2);
    time(i,12)=etime(time(i,:),time(2,:));
    time(i,13)=time(i,12)/3.5;
 end
time=sortrows(time,12);


for i=1:length(ship)
% determines number of steps required to transit area (distance divided by
% speed/steps)
    stepdist(i,1)=ship(i,14)/(ship(i,2)*1.852*0.2777778)/3.5;
    stepdist(i,5)=ship(i,15);
    stepdist(i,4)=ship(i,1);
% determines distance per step in east and north directions    
    stepdist(i,2)=ship(i,12)/stepdist(i,1);
    stepdist(i,3)=ship(i,13)/stepdist(i,1);
    ship(i,17)=stepdist(i,1);
    ship(i,18)=stepdist(i,2);
    ship(i,19)=stepdist(i,3);
end
stepdist=sortrows(stepdist,5);

% i know that this is in here twice, but it's the only way to make
% time/etime, etc work. FIGURE IT OUT.
for i=1:length(ship);
    time(i,7)=ship(i,1);
    time(i,8)=ship(i,2);
    time(i,12)=etime(time(i,:),time(2,:));
    time(i,13)=time(i,12)/3.5;
    ship(i,21)=time(i,13);
%     ship(i,16)=time(i,13)+stepdist(i,1);
end
time=sortrows(time,12);
ii=find(ship(:,21)>=0);
ship=ship(ii,:);
ii=find(time(:,13)>=0);
time=time(ii,:);
stepdist = stepdist(2:end,:);

for i=1:length(ship);
    ship(i,16)=time(i,13)+stepdist(i,1);
end


for i = 1:length(shipx);
    for j = 1:stepdist(2,1);
        %%determines number of steps -- should come from stepdist(i,1)
        if j == 1
            %%sets initial x y coordinates
            shipx(j,i)=ship(2,3);
            shipy(j,i)=ship(2,4);
        elseif j>1
            %%sets amount of movement in x and y dir at every step
            %%(converted knots to m/step to degrees/step.
            shipx(j,i)=shipx(j-1,i)-stepdist(2,2);
            shipy(j,i)=shipy(j-1,i)-stepdist(2,3);
        end
    end
end

return

% sets starting point of whales
RIWHx=[-64.7906 -64.8207 -64.8301];
RIWHy=[42.6690 42.6525 42.6474];

% sets right whale movement: speed=1.5 m/s
RIWHmovex=repmat(RIWHx,8526,1);
RIWHmovex=RIWHmovex+cumsum(unifrnd(-0.000047,0.000047,8526,3));
RIWHmovey=repmat(RIWHy,8526,1);
RIWHmovey=RIWHmovey+cumsum(unifrnd(-0.000067,0.000067,8526,3));

figure(1),clf
hold on
for j = 1:length(RIWHx);
    A=plot(RIWHmovex(:,j),RIWHmovey(:,j),'.');
    set(A,'color','g','markersize', 5);
    A1=plot(RIWHmovex(:,j),RIWHmovey(:,j),'-');
    set(A1,'color','g', 'linewidth', 1);
    %     text(shipx(i),shipy(i),num2str(i)); text(RIWHmovex(i),RIWHmovey(i),num2str(i));
    %     if abs(shipx(i)-RIWHmovex(i))<0.0001 & abs(shipy(i)-RIWHmovey(i))<0.0001
    %         pause
    %     end
end

% determines collision based on distance between vessel and whale in km,
% eliminates track of whale (=NaN) after collision.
for j = 1:size(RIWHmovex,2)
    for i=1:length(shipx)
        x(i,j)=(deg2rad(RIWHmovex(i,j))-deg2rad(shipx(i)))*(6372)*cos(deg2rad(shipy(i)));
        y(i,j)=(deg2rad(RIWHmovey(i,j))-deg2rad(shipy(i)))*(6372);
        % heading of vessel/direction angle - heading degrees, converted to
        % radians; heading taken from 'ship' matrix, determined above.
        a(i,j)=(cos(deg2rad(ship(3,11)))*x(i,j))+(sin(deg2rad(ship(3,11)))*y(i,j));
        b(i,j)=(-sin(deg2rad(ship(3,11)))*x(i,j))+(cos(deg2rad(ship(3,11)))*y(i,j));
        % defines a collision, based on the dimensions of the ship
        if abs(a(i,j))<=(ship(3,7)/1000) & abs(b(i,j))<=(ship(3,8)/1000)
            hit(i,j)=1; RIWHmovex(i+1:end,j)=NaN; RIWHmovey(i+1:end,j)=NaN;
        else hit(i,j)=0;
        end
    end
end
hitind=sum(hit);

clear ii
for j = 1:size(hit,2);
    if hitind(j)==1
        ii(j)=find(hit(:,j)==1);
    else ii(j)=0
    end
end
%%collision occurs at these steps

%    hitind2 = find((ii)>=1);
%    ii  = ii(hitind2);
   
figure(2),clf
for j = 1:size(RIWHmovex,2);
    H=plot(shipx(:),shipy(:),'.');
    hold on
    set(H, 'color','b', 'markersize', 5);
    H1=plot(shipx(:),shipy(:),'-');
    set(H1, 'color','b', 'linewidth', 1);
%     if ii(j)<=0
%         A=plot(RIWHmovex(:,j),RIWHmovey(:,j),'.');
%         set(A,'color','g','markersize', 5);
%         hold on
%         A1=plot(RIWHmovex(:,j),RIWHmovey(:,j),'-');
%         set(A1,'color','g', 'linewidth', 1);
%     elseif ii(j)>0
        jj=find(ii>=1)
        iii=ii(jj)
        hold on
        A=plot(RIWHmovex(:,j),RIWHmovey(:,j),'.');
        set(A,'color','g','markersize', 5);
        A1=plot(RIWHmovex(:,j),RIWHmovey(:,j),'-');
        set(A1,'color','g', 'linewidth', 1);
        if ii(j)>0
        H2=plot(shipx(ii(j)),shipy(ii(j)),'.');
        set(H2, 'color','r', 'markersize', 5);
        A2=plot(RIWHmovex(ii(j),j),RIWHmovey(ii(j),j),'.');
        set(A2,'color','r','markersize', 5);
        end
    %     text(shipx(i),shipy(i),num2str(i)); text(RIWHmovex(i),RIWHmovey(i),num2str(i));
    %     if abs(shipx(i)-RIWHmovex(i))<0.0001 & abs(shipy(i)-RIWHmovey(i))<0.0001
    %         pause
    %     end
end
