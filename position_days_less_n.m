%% to choose fewer whales than initial random selection


n =  size(posx1,2);
clear positionx positiony

for j=1:n
    positionx(1:24686,j)=posx1(1:24686,j);
    positiony(1:24686,j)=posy1(1:24686,j);
    positionx(24686:49371,j)=posx2(1:24686,j);
    positiony(24686:49371,j)=posy2(1:24686,j);
    
    positionx(49372:74057,j)=posx3(1:24686,j);
    positiony(49372:74057,j)=posy3(1:24686,j);
    
    positionx(74058:98743,j)=posx4(1:24686,j);
    positiony(74058:98743,j)=posy4(1:24686,j);
    
    positionx(98744:123429,j)=posx5(1:24686,j);
    positiony(98744:123429,j)=posy5(1:24686,j);
    
    positionx(123430:148115,j)=posx6(1:24686,j);
    positiony(123430:148115,j)=posy6(1:24686,j);
    
    positionx(148115:172800,j)=posx7(1:24686,j);
    positiony(148115:172800,j)=posy7(1:24686,j);
    
    positionx(172801:197486,j)=posx8(1:24686,j);
    positiony(172801:197486,j)=posy8(1:24686,j);
    
    positionx(197486:222171,j)=posx9(1:24686,j);
    positiony(197486:222171,j)=posy9(1:24686,j);
    
    positionx(222172:246857,j)=posx10(1:24686,j);
    positiony(222172:246857,j)=posy10(1:24686,j);
    
    positionx(246858:271543,j)=posx11(1:24686,j);
    positiony(246858:271543,j)=posy11(1:24686,j);
    
    positionx(271544:296229,j)=posx12(1:24686,j);
    positiony(271544:296229,j)=posy12(1:24686,j);
    
    positionx(296230:320915,j)=posx13(1:24686,j);
    positiony(296230:320915,j)=posy13(1:24686,j);
    
    positionx(320915:345600,j)=posx14(1:24686,j);
    positiony(320915:345600,j)=posy14(1:24686,j);
    
    positionx(345601:370286,j)=posx15(1:24686,j);
    positiony(345601:370286,j)=posy15(1:24686,j);
    
end

return

% 
% positionx(:,1:41) = positionx(:,42:82);
% positionx = positionx(:,1:41);
% positiony(:,1:41) = positiony(:,42:82);
% positiony = positiony(:,1:41);



positionx(:,1:41) = positionx(:,82:122);
positionx = positionx(:,1:41);
positiony(:,1:41) = positiony(:,82:122);
positiony = positiony(:,1:41);