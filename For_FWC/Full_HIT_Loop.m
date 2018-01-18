
for idx = 1:30;
    idn = '/Volumes/JULIE/EXTERNAL_DATA/THESIS/';
    filename = sprintf('sept1-15-2006-%d',idx);
    fid = [idn filename]
    load(fid)
    
    positionx = vertcat(posx1, posx2, posx3, posx4, posx5, posx6, posx7, posx8, posx9, posx10, posx11, posx12, posx13, posx14, posx15);
    positiony = vertcat(posy1, posy2, posy3, posy4, posy5, posy6, posy7, posy8, posy9, posy10, posy11, posy12, posy13, posy14, posy15);
    
    HIT
end
