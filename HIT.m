clear H MMSI ans colours counter deleast filelist filename i idn ifn ii ind ind_ii j sizevess_ROS

tic
count = 0;
for tsteps=1:24686;
    [xship,yship] = ship_positions_jv(tsteps,ship,AIS); % where are the ships at tstep
    [xwhales,ywhales] = whalepositions(tsteps,positionx,positiony); % where are the whales at tstep
    
    tdays = datenum([(AIS(1,3)+2000),AIS(1,2),AIS(1,1),AIS(1,4),AIS(1,5),AIS(1,6)+3.5*tsteps]);
    I = find(tdays >= ship(:,15) & tdays <= ship(:,20));
    ii = find(yship > 42.6 & yship < 43.3 & xship < -64.8 & xship > -66.1);
    
    if I(ii) > 1  % if there is at least one ship in the domain
        for i = 1:length(xwhales) % for all whales and all ships, are they in the same place at the same time?
            for j = 1:length(xship)
                
                x(i,j)=(deg2rad(xwhales(i))-deg2rad(xship(j)))*(6372)*cos(deg2rad(yship(j)));
                y(i,j)=(deg2rad(ywhales(i))-deg2rad(yship(j)))*(6372);
                
                a=(cos(deg2rad(ship(I(j),11)))*x)+(sin(deg2rad(ship(I(j),11)))*y);
                b=(-sin(deg2rad(ship(I(j),11)))*x)+(cos(deg2rad(ship(I(j),11)))*y);
                
                if abs(a(i,j))<=(ship(I(j),7)/1000) & abs(b(i,j))<=(ship(I(j),8)/1000)
                    
                    count = count+1;
                    
                    hit_time(count,:) = datevec(tdays) % date/time of coincidence
                    hit_whales(count,:) = [xwhales(i) ywhales(i) i]; % whale coordinates and whale number
                    hit_ships(count,:) = [xship(j) yship(j) j ship(j,1) ship(j,2)]; % ship coordinates, ship number, MMSI and ship speed
                    
                else continue
                end
            end
        end
    end
end


toc