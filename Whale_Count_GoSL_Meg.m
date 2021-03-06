clear

%% Defines the large 500 grid area
gsize = 2*0.1; 
% lats = 45.5:0.05:51;
lats = 45.5:gsize:51;
lats = lats';
% longs =-57:-0.05:-66;
longs =-57:-gsize:-66;
longs = longs';
elong = longs + -gsize;
elat = lats + gsize;


longgrid = repmat(longs,[size(lats,1),1]);
latgrid = repmat(lats, [size(longs,1),1]);
longgrid = sort(longgrid,1);
elonggrid = repmat(elong,[size(lats,1),1]);
elatgrid = repmat(elat, [size(longs,1),1]);
elonggrid = sort(elonggrid,1);

Boxes = [longgrid latgrid elonggrid elatgrid]; % the corners of each grid square

cd /Users/julievanderhoop/Documents/MATLAB/UGthesis
[num,txt] = xlsread('Sightings_Tracker_Sheet_subset.xlsx');

%% data cleaning
% convert all longs to negative
num(:,4) = -abs(num(:,4));
% select those within our time frame and region of interest
latlim = [min(lats) max(elat)];
lonlim = [min(longs) max(elong)];
num = num(find(iswithin(num(:,3),latlim)),:);
num = num(find(iswithin(num(:,4),lonlim)),:);


Whales = [num(:,4) num(:,3) num(:,5)]; % first column = longitude; second column = latitude; 3rd column = n whales


%% This loop finds the whale information in each grid square and assigns it the its proper gridname
%% variable


for k = 1:length(Boxes)
    ii = find(Whales(:,1) > Boxes(k,3) & Whales(:,1) <=Boxes(k,1)...
        & Whales(:,2) < Boxes(k,4) & Whales(:,2) >= Boxes(k,2));
    if isempty(ii) == 0
        Boxes(k,5) = sum(Whales(ii,3)); % number of whales %% length(ii); % number of entries
    end
end


%% Takes the information from spdhdavg, but changes the lats and longs from the lower left hand corner
%% of each grid square to the centre coordinate of the grid square
Whale_count(:,1) = Boxes(:,1) - gsize;
Whale_count(:,2) = Boxes(:,2) + gsize;
Whale_count(:,3) = Boxes(:,5);
Whale_count(:,4) = Whale_count(:,3)./sum(Boxes(:,5));

%% Reshape into a surface/2D distribution

A = reshape(Whale_count(:,4),length(lats),length(longs));
figure(3), hold on
mesh(flipud(longs),lats,A)

%% resample at finer grid? 
[Xq,Yq] = meshgrid(-66:gsize/2:-55,45:gsize/2:51); 

Vq = interp2(flipud(longs),lats,Whale_count(:,4),Xq,Yq); 

% Sample from distribution
% N = 10; % number of samples
% vals=zeros(2,N); % preallocate for speed
% for i=1:N
%     [vals(1,i),vals(2,i)]=pinky(flipud(longs),lats,A);
% end
% figure(1)
% plot(vals(1,:),vals(2,:),'ro')

%% save
save('GoSL2017_PDF_Meg','A','Whales','lats','longs','Whale_count')

%% plot map and sightings
GoSL_whales_fig
hold on, plot(Whales(:,1),Whales(:,2),'o')
ylim([45 50.5]), xlim([-66.7 -59])
print -dpng GoSL_MegWhales_28Feb2018 -r300