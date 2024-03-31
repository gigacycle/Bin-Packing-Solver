clc;
clear;
nObject = 40;      %tedade ashya
nBinpack = 40;    %tedade koole poshti-ha
maxW = 4;          %hadde aksare vazne ashya
binpackCap = 10; %zarfiate koole poshti-ha
 if ((nBinpack*binpackCap)<nObject*maxW)
    display('tedade kifha kamtar az hade mojaz ast');
    return;
end
%sakhtane ashya be soorate tasadofi
objects = makeObjects(nObject,maxW);
bp = arrange(objects, nBinpack, binpackCap);
cost = bpCost(bp);
cnt = 1;
Cost(1) = cost;
BP{1} = bp;
bestArrange.bp = bp;
bestArrange.cost = Cost(1);
T = binpackCap;    %damaye avalie
maxCount = 100;
zaman = [];
hold on;
while (cnt<=maxCount)
    tic;
    cnt = cnt +1;
    BP{cnt} = neighbourSA(BP{cnt-1},0.5,binpackCap);
    Cost(cnt) = bpCost(BP{cnt});
    delta=Cost(cnt)-Cost(cnt-1);
    if delta<=0
        bestArrange.bp=BP{cnt};
        bestArrange.cost = Cost(cnt);
    else
        p=exp(-delta/T);
        if rand<p
            bestArrange.bp=BP{cnt};
            bestArrange.cost = Cost(cnt);
        end
    end

    T=T*0.8;
    display(['tekrar: ' num2str(cnt)  ' - tedade kif-ha : ' num2str(bestArrange.cost)]);
    plot(cnt,T,'.'); 
    zaman(end+1) = toc;
    pause(0.05);
end
hold off;
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(bestArrange.cost)]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
figure;
plot(zaman);
figure;
plot(Cost);
