vess = [-20 -40; -20 60; 10 60; 10 -40; -20 -40;];
theta = linspace(-pi, pi);
radius = [10.5:1.5:18];
radius(2,:) = 18;
vess_out = [-28 -48; -28 68; 18 68; 18 -48; -28 -48;];
r = 8;
x = 18;
y = 18;
vess_cross = [-5 -40; -5 60; -20 10; 10 10];

circ(:,1) = r*cos(theta)+x;
circ(:,2) = r*sin(theta)+x;

figure(1),clf
hold on
set(gcf, 'Position',[222    -17   1059  701])
plot(vess_out(:,1),vess_out(:,2),'k--','linewidth',1.5)
plot(circ(1:3:end,1),circ(1:3:end,2),'ko','markerfacecolor','k','markersize',2)
% plot(r*cos(theta)+x, r*sin(theta)+y,'k.','markersize',2)
plot(radius(1,:),radius(2,:),'ko','markerfacecolor','k','markersize',2)

set(gcf, 'color', 'white');
plot(vess(:,1),vess(:,2),'k-','linewidth',1.5)
plot(vess_cross(1:2,1),vess_cross(1:2,2),'k','linewidth',1.5)
plot(vess_cross(3:4,1),vess_cross(3:4,2),'k','linewidth',1.5)
axis equal
axis off

text(-15,13,'Vb','fontsize',14)
text(-4,35,'Vl','fontsize',14)
text(11,21,'1/2Wl','fontsize',14)

print -r300 -dtiff vanderHoop_Figure5.tif
