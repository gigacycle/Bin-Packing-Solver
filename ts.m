clc;
clear;
nObject = 40;      %tedade ashya
nBinpack = 40;    %tedade koole poshti-ha
maxW = 4;          %hadde aksare vazne ashya
binpackCap = 10; %zarfiate koole poshti-ha
 if ((nBinpack*binpackCap)<nObject*maxW)
     display('Tedade kifha kamtar az hadde mojaz ast.');
    return;
end
%sakhtane ashya be soorate tasadofi
objects = makeObjects(nObject,maxW);
arrange = arrange(objects,nBinpack, binpackCap);
bestArrange = arrange;
bestCost = bpCost(arrange);
display(['tedade kifha (1) :'  num2str(bestCost)]);
tabu = {};
maxIt = 100;
zaman = [];
for It=2:maxIt
    tic;
    neighbours = neighbourTS(arrange, binpackCap, tabu);
    newArrange = bestNeighbour(neighbours);
    cost(It) = bpCost(newArrange);
    if (cost(It) < bestCost)
        tabu{end+1} = newArrange;
        bestArrange = newArrange;
        bestCost = cost(It);
    end
    display(['tekrar: ' num2str(It) ' - tedade kifha :'  num2str(bestCost)]);
    zaman(end+1) = toc;
end
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(bestCost)]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
for i=1:size(bestArrange,2)
    display(['kif ' num2str(i) ' : zarfiate baghi mande : ' num2str(bestArrange(i).ca) ' - tedade ashyaye dakhele kif : ' num2str(bestArrange(i).objCount)]);
    for j = 1:bestArrange(i).objCount
        display(['shey  ' num2str([bestArrange(i).obj{j}.id])]);
    end
end
figure;
plot(zaman);
figure;
plot(cost);