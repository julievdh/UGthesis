function [Whale_count,A,longs,lats] = Whale_Count_GoSL_fun(Whales)
% Inputs:
    % Whales is first column = longitude; second column = latitude; 3rd column = n whales
% Outputs: 
    % Whale_count is boxes with whale counts
    % A is reshaped for mesh/surface/countour
    % longs/lats are box edges 

%%%%%%%%%%%%%%%%databybox_spdhdn%%%%%%%%%%%%%%%%%%%%%%
%% Defines the large 500 grid area
lats = 45.5:0.1:50;
lats = lats';
longs =-59:-0.1:-66;
longs = longs';
elong = longs + -0.1;
elat = lats + 0.1;


longgrid = repmat(longs,[size(lats,1),1]);
latgrid = repmat(lats, [size(longs,1),1]);
longgrid = sort(longgrid,1);
elonggrid = repmat(elong,[size(lats,1),1]);
elatgrid = repmat(elat, [size(longs,1),1]);
elonggrid = sort(elonggrid,1);

Boxes = [longgrid latgrid elonggrid elatgrid]; % the corners of each grid square

% addpath('/Users/julievanderhoop/Documents/MATLAB/Thesis'); addpath('/Users/julievanderhoop/Documents/MATLAB/UGthesis')
% quicklook_whales

% Whales = [num(:,4) num(:,3) num(:,5)]; % first column = longitude; second column = latitude; 3rd column = n whales


%% This loop finds the whale information in each grid square and assigns it the its proper gridname
%% variable


for k = 1:length(Boxes)
    ii = find(Whales(:,1) > Boxes(k,3) & Whales(:,1) <=Boxes(k,1)...
        & Whales(:,2) < Boxes(k,4) & Whales(:,2) >= Boxes(k,2));
    Boxes(k,5) = length(ii); % sum(Whales(ii,3)); % number of whales %% length(ii); % number of entries
end


%% Takes the information from spdhdavg, but changes the lats and longs from the lower left hand corner
%% of each grid square to the centre coordinate of the grid square
Whale_count(:,1) = Boxes(:,1) - 0.05;
Whale_count(:,2) = Boxes(:,2) + 0.05;
Whale_count(:,3) = Boxes(:,5);
longs = longs - 0.05;
lats = lats + 0.05; % recenter these too
%% Reshape into a surface/2D distribution

A = reshape(Whale_count(:,3),length(lats),length(longs));
% figure(3), hold on
% mesh(flipud(longs),lats,A)

