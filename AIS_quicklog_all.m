% Quick log check
% plots the data for a visual check
% eventually puts in a log allowing to bring all the data together

close all; clear all; clc

AIS = [0 0 0 0 0 0 0 0 0 0];

idn = 'C:\Documents and Settings\Julie Van der Hoop\My Documents\Fourth Year\Thesis\Data\AIS_quicklogs\';
filename = 'quicklogs_ROS2007.list';
filelist = rd_list([idn filename]);

for i = 1:length(filelist)
  ifn  = filelist{i};

  [day, month, year, hour, minute, second, TZ, MMSI, Status, ROT, Speed, PA, Latitude, Longitude, COG, Heading, UTC] ...
      = textread([idn ifn], '%n %n %n %n %n %n %s %n %s %n %n %s %n %n %n %n %n', 'delimiter',','); %% reads in the data from the .tx2 file
  useful_AIS = [day, month, year, hour, minute, second, MMSI, Speed, Latitude, Longitude];

  AIS = [AIS; useful_AIS];

  clear day month year hour minute second TZ MMSI Status ROT Speed PA Latitude Longitude COG Heading UTC useful_AIS
end

AIS = AIS(2:end, :);
