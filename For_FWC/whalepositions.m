function [x,y] = whalepositions(tsteps,positionx,positiony)
[ignore,nwhales] = size(positionx);  
x = positionx(tsteps,:);y = positiony(tsteps,:);
x = x';y = y';