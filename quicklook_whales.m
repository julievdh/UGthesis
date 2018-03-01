clear 
cd /Users/julievanderhoop/Documents/MATLAB/UGthesis
[num,txt] = xlsread('Sightings_Tracker_Sheet_subset.xlsx');

%% data cleaning
% convert all longs to negative
num(:,4) = -abs(num(:,4));
% select those within our time frame and region of interest
latlim = [45.5 50];
lonlim = [-66 -59];
num = num(find(iswithin(num(:,3),latlim)),:);
num = num(find(iswithin(num(:,4),lonlim)),:);
% four time periods
biweek(:,1) = [datenum([2017 6 12 0 0 0]); datenum([2017 6 25 0 0 0]); datenum([2017 7 9 0 0 0]); datenum([2017 7 23 0 0 0]); datenum([2017 8 6 0 0 0]); datenum([2017 8 20 0 0 0])];
biweek(:,2) = biweek(:,1)+13; % because including first day

for w = 1:length(biweek) % do this for all weeks
num_bw = num(find(iswithin(x2mdate(num(:,1)),[biweek(w,1)-1 biweek(w,2)])),:); % choose dates in 2 week window

figure(1), clf,
plot(num_bw(:,4),num_bw(:,3),'o')

% GoSL_whales_fig

% build distribution
[Whale_count,A,longs,lats] = Whale_Count_GoSL_fun([num_bw(:,4) num_bw(:,3)]);

    for d = 1:14 % do this for 14 days within the biweekly periods
        dnum(d) = (w*14)-14+d; % this is the day number for position indexing so as to not overwrite 
        % pick whales
        n = 10; % number of samples
        vals=zeros(2,n); % preallocate for speed
        for i=1:n
            [vals(1,i),vals(2,i)]=pinky(flipud(longs),lats,A);
        end
        figure(1), hold on
        plot(vals(1,:),vals(2,:),'ro')
        
        % swim whales
        del_t = 2.5; t = 1*24*3600; % 1 day
        [positions(dnum(d)).x,positions(dnum(d)).y] = CRW_fun(vals(1,:),vals(2,:),t,del_t); % example, 1 day
        positions(dnum(d)).date = biweek(w,1)+d-1; % day 
        positions(dnum(d)).time = 1:del_t:t; % in seconds 
    end
end

% Plot all positions
GoSL_whales_fig, hold on
plot(num(:,4),num(:,3),'o')
for i = 1:length(positions)
plot(positions(i).x,positions(i).y)
end
print -dpng GoSL_SwimWhalesCrab_28Feb2018 -r300
save('22jun20aug_positions','positions')
