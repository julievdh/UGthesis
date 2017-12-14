function [x,y] = ship_positions_jv(tsteps,ship,AIS)
nships = size(ship,1);
tdays = datenum([(AIS(1,3)+2000),AIS(1,2),AIS(1,1),AIS(1,4),AIS(1,5),AIS(1,6)+3.5*tsteps]);
I = find(tdays >= ship(:,15) & tdays <= ship(:,20));

if I >= 0
    t1 = datevec(ship(I,15));
    t2 = datevec(tdays);
    
    for i = 1:size(t1,1)
        elapse(i) = (etime(t2,t1(i,:))/3.5);
    end
    
    for i = 1:size(t1,1)
        delt(I(i)) = elapse(i); % time elapsed since entry
    end
    x = ship(I,3)+(delt(I)'.*ship(I,18)); % ship entry long + travel
    y = ship(I,4)+(delt(I)'.*ship(I,19)); % ship entry lat + travel
else x = NaN;
    y = NaN;
end
