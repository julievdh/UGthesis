    function [positionx,positiony] = CRW_fun(x,y,t,del_t)

% Simulates swimming tracks for n whales over a specified number of time 
% steps by means of a correlated random walk (CRW). 

% x and y are coordinates of whales 
% t is the amount of time in seconds the model should run for
% del_t is the timestep of the model 

% Parameters as entered reflect North Atlantic right whales

% CRW is constrained by choosing a random direction from an experimentally 
% determined range of turning angles (RCD; Mayo and Marx 1990), and randomly 
% choosing swimming speed from a uniform distribution of 0 to 1.23 m/s where 
% the maximum was based on the upper 95% CI of swimming speeds for satellite-
% tagged right whales (Baumgartner and Mate 2005).

% Julie van der Hoop
% jvanderhoop@whoi.edu

% del_t = 3.5; % length of time step (seconds)

% x = [-65.0130 -65.0934 -65.0812 -65.0882]; % longitudes of initial locations
% y = [42.9333 42.9518 42.9542 42.9578]; % latitudes of initial locations

n = size(x,2); % number of whales based on the number of initial locations
tsteps = t/del_t; % number of time steps 
% tsteps = 24686; % number of del_t time steps over which you want to run model
% (24686*del_t = 1 day)

% set initial random distance traveled over del_t time step
max_speed = 1.23;
max_dist = km2deg((max_speed*del_t)/1000);
dis = unifrnd(0,max_dist,1,n);

% set initial random direction
dir = unifrnd(-pi,pi,1,n); 
RCD = 22.1; % maximum rate of change of direction
max_dir = deg2rad((RCD/10)*max_speed*del_t);

% preallocate for speed
positionx = nan(round(tsteps),n);
positiony = nan(round(tsteps),n);
for    i = 1:tsteps;
    for j = 1:n
        x(j) = x(j)+(cos(dir(j))*dis(j));
        y(j) = y(j)+(sin(dir(j))*dis(j));
    end
    positionx(i,:) = x;
    positiony(i,:) = y;
    dir = dir+unifrnd(-max_dir,max_dir,1,n);
    dis = unifrnd(0,max_dist,1,n);
end
% display data
for j = 1:n
    hold on
    plot(positionx(1,j),positiony(1,j),'b.')
    plot(positionx(:,j),positiony(:,j))
end
%scbar = [-65.14 42.85; -65.1215 42.85];
%text(-65.14,42.86,'1.5 km','fontsize',12, 'fontweight','bold', 'backgroundcolor', 'w')
%plot(scbar(:,1), scbar(:,2), 'k-', 'linewidth', 5)