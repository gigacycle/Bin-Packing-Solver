clc;
clear;
nObject = 40;      %tedade ashya
nBinpack = 100;    %tedade koole poshti-ha
maxW = 5;          %hadde aksare vazne ashya
binpackCap = 10; %zarfiate koole poshti-ha
if (nBinpack*binpackCap<nObject*maxW)
    display('Tedade kifha kamtar az hadde mojaz ast.');
    return;
end
%sakhtane ashya be soorate tasadofi
objects = makeObjects(nObject,maxW);

nZanboor = 200;
maxCount = 20;

model=struct();
model.id=0;
model.setObj=objects(1);
model.arrange = {};
model.cost=inf;

zanboor(1:nZanboor) = model;
nPishro = ceil(nZanboor/20);
Pishro(1:nPishro) = model;
javab = model;
zaman=[];
for cnt=1:maxCount
    tic;
    if (cnt==1)
        % harekat be samte shahde gol
        for i=1:nZanboor
            area = objects;
            for j=1:nObject
                indx = fix(1+rand*(size(area,2) - 1)); 
                zanboor(i).setObj(end+1) = area(indx);
                area(indx) = [];
            end
            zanboor(i).arrange = setObjects(zanboor(i).setObj,binpackCap);
            zanboor(i).cost = bpCost(zanboor(i).arrange);
            zanboor(i).id=i;
        end
        % bargashtane zanboorha be kandoo
        %moratab sazi bar hasbe barazandegi
        tempCost(:,1) = [zanboor.id];
        tempCost(:,2) = [zanboor.cost];
        tempCost = sortrows(tempCost, 2);
        if (javab.cost > tempCost(1,2))
            javab = zanboor(tempCost(1,1));
        end
        for i=1:size(Pishro,2)  %entekhabe zanboore pishro
            Pishro(i) = zanboor(tempCost(i,1));
        end
    else
        % harekat be samte shahde gol
        for i=1:nZanboor
            fnd = find([Pishro.id]==i);
            if (size(fnd,2)>0) 
     continue;
            end
            zanboor(i) = model;
            indx = fix(1+rand*(size(Pishro,2)-1)); %entekhabe zanboore pishro
            pishro = Pishro(indx);
            p = 1/(pishro.cost+0.01);
            follow = 1;
            for j=1:nObject
                if ((rand>p) && (~follow)) %entekhabe rahe pishro ya yek rahe jadid (zanboorhaye gheyre pishro)
                    area = objects;
                    remainList = setdiff([area.id], [zanboor(i).setObj.id]);
                    ind = fix(1+rand*(size(remainList,2)-1));
                    indx = find([area.id] == remainList(ind));
                    zanboor(i).setObj(j) = area(indx);
                else  %
                    zanboor(i).setObj(j) = pishro.setObj(j);
                    if (rand>p)
                        follow=0;
                    end
                end
            end
            zanboor(i).arrange = setObjects(zanboor(i).setObj,binpackCap);
            zanboor(i).cost = bpCost(zanboor(i).arrange);
            zanboor(i).id=i;
        end
        % bargashtane zanboorha be kandoo
        %zanboor share their cost to others at hive
        tempCost(:,1) = [zanboor.id];
        tempCost(:,2) = [zanboor.cost];
        tempCost = sortrows(tempCost, 2);
        if (javab.cost > tempCost(1,2))
            javab = zanboor(tempCost(1,1));
        end
        for i=1:size(Pishro,2) %selecting pishro zanboor
            Pishro(i) = zanboor(tempCost(i,1));
        end
    end
    Cost(cnt) = javab.cost;
    display(['tekrar: ' num2str(cnt) ' - tedade kif-ha : ' num2str(javab.cost)]);    
    zaman(end+1) = toc;    
end
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(javab.cost)]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
figure;
plot(zaman);
figure;
plot(Cost);