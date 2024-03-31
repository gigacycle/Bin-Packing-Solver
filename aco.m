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

Nodes = repmat(1:nObject,nObject,1);
nNodes=size(Nodes,2);
etha=1./(Nodes+1);
tau0=1;
tau=tau0*ones(nObject,nNodes);
alpha=1;
beta=2;
rho=0.055;
nAnt=nNodes;
empty_ant=struct();
empty_ant.indexing=[];
empty_ant.arrange=[];
empty_ant.cost=0;
empty_ant.P=[];
ant=repmat(empty_ant,nAnt,1);
max_it=100;
best_cost=2*nObject;
minCost.arrange = [];
Cost=[];
zaman=[];
for t=1:max_it
    tic;
    for k=1:nAnt
        ant(k).indexing=randint(1,1,[1 nNodes]);  %halate baadi har mourche
    end
    for i=2:nObject
        for k=1:nAnt
            N=setdiff(1:nObject, ant(k).indexing); %gere haee ke mourche az aan gozar nakarde
            ant(k).P=zeros(1,nNodes); 
            ii=ant(k).indexing(end); % latest node of current ant
            for j=1:numel(N)
                jj=N(j); 
                ant(k).P(jj)=tau(ii,jj)^alpha*etha(ii,jj)^beta;
            end
            ant(k).P=ant(k).P/sum(ant(k).P);
            ant(k).indexing(end+1)=SelectWithProbability(ant(k).P);
        end
    end
    for k=1:nAnt    %mohasebe amale Ejraee
        for j=1:size(ant(k).indexing,2)
            newSet(j) = objects(ant(k).indexing(j));
        end
        ant(k).arrange = setObjects(newSet, binpackCap);
        ant(k).cost=bpCost(ant(k).arrange)+0.0001;
        for i=1:nObject
            ii=newSet(i).id;
            if i<nObject
                jj=newSet(i+1).id;
            else
                jj=newSet(1).id;
            end
            tau(ii,jj)=tau(ii,jj)+(1/ant(k).cost);
            tau(jj,ii)=tau(ii,jj);
        end
    end
    tau=(1-rho)*tau;
    [minCost.cost index] = min([ant.cost]);
    if (minCost.cost<best_cost)
        best_cost = minCost.cost;
        minCost.arrange = ant(index).arrange;
    end
    Cost(end+1) = best_cost;
    disp(['tekrar: ' num2str(t) ' - tedade kif-ha : ' num2str(fix(best_cost))]);
    zaman(end+1) = toc;
end
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(fix(best_cost))]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
figure;
plot(zaman);
figure;
plot(Cost);