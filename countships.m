% counts the number of vessels transiting ATBA in a given time period

ATBA = [-64.9167 43.2667;  -64.9833 42.7833; -65.5167 42.65; -66.0833 42.8667; -64.9167 43.2667]; % Roseway Basin ATBA
% count = 0;

for i = 1:length(sepvess)
IN = inpolygon(sepvess{i}(:,10),sepvess{i}(:,9),ATBA(:,1),ATBA(:,2));
ii = find(IN == 1);
if isempty(ii) < 1
count = count + 1;
end
end

return

% check with figure
hold on
for i = 1:length(sepvess)
plot(sepvess{i}(:,10),sepvess{i}(:,9))
end
plot(ATBA(:,1),ATBA(:,2),'r-','LineWidth',2)