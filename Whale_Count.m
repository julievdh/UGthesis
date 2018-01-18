                     %%%%%%%%%%%%%%%%databybox_spdhdn%%%%%%%%%%%%%%%%%%%%%%
%% Defines the large 500 grid area
lats = 42.5:0.05:43.45;
lats = lats';
longs =-64.75:-0.05:-65.95;
longs = longs';
elong = longs + -0.05;
elat = lats + 0.05;


longgrid = repmat(longs,[20,1]);
latgrid = repmat(lats, [25,1]);
longgrid = sort(longgrid,1);
elonggrid = repmat(elong,[20,1]);
elatgrid = repmat(elat, [25,1]);
elonggrid = sort(elonggrid,1);

Boxes = [longgrid latgrid elonggrid elatgrid]; % the corners of each grid square

load('RIWHx'); load('RIWHy_adjusted');

Whales = [RIWHx' RIWHy']; % first column = longitude; second column = latitutde


%% This loop finds the whale information in each grid square and assigns it the its proper gridname
%% variable


for k = 1:length(Boxes)
   ii = find(Whales(:,1) > Boxes(k,3) & Whales(:,1) <=Boxes(k,1)...
     & Whales(:,2) < Boxes(k,4) & Whales(:,2) >= Boxes(k,2));
 Boxes(k,5) = length(ii);
end

  


%% Takes the information from spdhdavg, but changes the lats and longs from the lower left hand corner
%% of each grid square to the centre coordinate of the grid square
Whale_count(:,1) = Boxes(:,1) - 0.025;
Whale_count(:,2) = Boxes(:,2) + 0.025;
Whale_count(:,3) = Boxes(:,5);
