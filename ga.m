clc;
clear;
nObject = 40;      %tedade ashya
nBinpack = 30;    %tedade koole poshti-ha
maxW = 5;          %hadde aksare vazne ashya
binpackCap = 10; %zarfiate koole poshti-ha
 if ((nBinpack*binpackCap)<nObject*maxW)
    display('tedade kifha kamtar az hade mojaz ast');
    return;
end
%sakhtane ashya be soorate tasadofi
objects = makeObjects(nObject,maxW);
maxIt = 100;
%----------------tolid jameeiat----------------------------
popLen = input('Jamiate avvalie ra vared konid : ');
population = cell(popLen,2); % maghadir & rotbe bandi
sz = size(population,1);
for i=1:5
    population{i,1} = arrange(objects, nBinpack, binpackCap);
    population{i,2} = bpCost(population{i,1}) / ((sz+(sz+1))/2);
end
% moratab kardan bar asase rotebandi
population = sortrows(population, 2);

%entekhabe valed
parrent1 = population{1,1};
parrent2 = population{2,1};
minCost(1) = bpCost(population{1,1});
bestAnswer= population{1,1};
bestCost = minCost(1);
childs = cell(4,2);
zaman=[];
for It=1:maxIt
    tic;
    childs = crossOver(parrent1,parrent2,binpackCap);
     for i=1:size(childs,1)
         childs{i,1} = mutation(childs{i,1}, binpackCap);
         childs{i,2} = bpCost(childs{i,1}) / ((size(childs,1)+(size(childs,1)+1))/2);
     end
     % moratab kardan bar asase rotebandi
     childs = sortrows(childs, 2);
     minCost(It) = bpCost(childs{1,1});
     if (bestCost > minCost(It))
        bestCost = minCost(It);
        bestAnswer = childs{1,1};
     end
     %Entekhabe valed
     parrent1 = childs{1,1};
     parrent2 = childs{2,1};
     display(['tekrar : ' num2str(It) ' - tedade kif-ha : '  num2str(bestCost)]);
     zaman(end+1) = toc;
     pause(0.05);
end
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(bestCost)]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
figure;
plot(zaman);
figure;
plot(minCost);