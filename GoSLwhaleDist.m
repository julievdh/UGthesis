% GoSLwhaleDist
% ForAngelia

%% load processed data
load('GoSLwhalePositions')

%% plot contours of those whales
figure(1), clf, hold on, contour(flipud(longs),lats,A)

%% pull n values from distribution
n = 10; % number of samples
vals=zeros(2,n); % preallocate for speed
for i=1:n
    [vals(1,i),vals(2,i)]=pinky(flipud(longs),lats,A);
end
figure(1), hold on
plot(vals(1,:),vals(2,:),'ro')

%% swim the whales
tic
[posx,posy] = CRW_fun(vals(1,:),vals(2,:),1*24*3600,2.5); % example, 1 day
toc

%% try this:
% simulate 10 whales over n days
n = 10; % number of samples
for d = 1:54;
    
    vals=zeros(2,n); % preallocate for speed
    for i=1:n
        [vals(1,i),vals(2,i)]=pinky(flipud(longs),lats,A);
    end
    
    tic
    [posx,posy] = CRW_fun(vals(1,:),vals(2,:),d*24*3600,2.5); % example, 1 day
    elapsed(d) = toc;
    
    % reshape distributions
    %allx = reshape(posx,length(posx)*n,1);
    %ally = reshape(posy,length(posy)*n,1);
    
    % calculate whether distributions are statistically similar
    %[pk(d),D(d)] = kstest2d(Whales(:,1:2),[allx(1:100:end) ally(1:100:end)]);
end

% plot all
figure(10)
plot(1:d,elapsed)
xlabel('days simulated, 10 whales'), ylabel('seconds')

