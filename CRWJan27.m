x=[-65.0013 -65.0934 -65.0882 -65.0882];
y=[42.9333 42.9518 42.9572 42.9578];
dir=unifrnd(-pi,pi,1,4);
dis=unifrnd(0,0.0000472,1,4);

for    i=1:200;
    for j=1:4
        x(j)=x(j)+(cos(dir(j))*dis(j));
        y(j)=y(j)+(sin(dir(j))*dis(j));
    end
    positionx(i,:)=x;
    positiony(i,:)=y;
    dir=dir+unifrnd(-pi/2,pi/2,1,4);
    dis=unifrnd(0,0.0000472,1,4);
end

for j=1:4
    plot(positionx(:,j),positiony(:,j))
    hold on
end
