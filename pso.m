%% Paksazie Safhe 
clc;
clear;

%% Maghar-dehie Avvalie
nObject = 40;      %tedade ashya
nBinpack = 20;    %tedade koole poshti-ha
maxW = 4;          %hadde aksare vazne ashya
binpackCap = 10; %zarfiate koole poshti-ha
 if ((nBinpack*binpackCap)<nObject*maxW)
    display('tedade kifha kamtar az hade mojaz ast');
    return;
end
%sakhtane ashya be soorate tasadofi
objects = makeObjects(nObject,maxW); 

npop=100; %tedade zarat
nvar=100; %tedade khane haye araye-ye sorat
maxit=500;

w=1;
wdamp=0.99;

c1=2;
c2=2;

xmin=-10;
xmax=10;
dx=xmax-xmin;

vmax=0.1*dx;

empty_particle.position=[];
empty_particle.bp=[];
empty_particle.velocity=[];
empty_particle.cost=[];
empty_particle.pbest=[];%behtarin mogheyate zare
empty_particle.pbestcost=[];%hazinye javabe bartar

particle=repmat(empty_particle,npop,1);

gbest=zeros(maxit,nvar);
gbestcost=zeros(maxit,1);
gbestBP= cell(maxit,1);
zaman = [];
%%
for it=1:maxit
    tic;
    if it==1
        gbestcost(1)=inf;
        for i=1:npop
            particle(i).velocity=zeros(1,nvar);
            particle(i).position=xmin+(xmax-xmin)*rand(1,nvar);
            particle(i).bp = arrange(objects, nBinpack, binpackCap);
            particle(i).cost=bpCost(particle(i).bp);
            
            particle(i).pbest=particle(i).position;
            particle(i).pbestcost=particle(i).cost;
            
            if particle(i).pbestcost<gbestcost(it)
                gbest(it,:)=particle(i).pbest;
                gbestcost(it)=particle(i).pbestcost;
                gbestBP{it} = particle(i).bp;
            end
        end
    else
        gbest(it,:)=gbest(it-1,:);
        gbestcost(it)=gbestcost(it-1);
        gbestBP{it}=gbestBP{it-1};
        for i=1:npop
            particle(i).velocity=w*particle(i).velocity...
                                +c1*rand*(particle(i).pbest-particle(i).position)...
                                +c2*rand*(gbest(it,:)-particle(i).position);
                            
            particle(i).velocity=min(max(particle(i).velocity,-vmax),vmax);
            
            particle(i).position=particle(i).position+particle(i).velocity;
            
            particle(i).position=min(max(particle(i).position,xmin),xmax);
            
            particle(i).bp = arrange(objects, nBinpack, binpackCap);
            
            particle(i).cost=bpCost(particle(i).bp);
            
            if particle(i).cost<particle(i).pbestcost
                particle(i).pbest=particle(i).position;
                particle(i).pbestcost=particle(i).cost;

                if particle(i).pbestcost<gbestcost(it)
                    gbest(it,:)=particle(i).pbest;
                    gbestcost(it)=particle(i).pbestcost;
                    gbestBP{it} = particle(i).bp;
                end
            end
        end
    end
    
    disp(['tekrar : ' num2str(it) ' - tedade kif-ha : ' num2str(gbestcost(it))]);
    
    w=w*wdamp;
    zaman(end+1) = toc;
end
display(['tedade ashya : ' num2str(nObject) ' hadde aksar vazn : ' num2str(maxW) ' tedade kifha : ' num2str(gbestcost(end))]);
display(['Zarfiate har kif : ' num2str(binpackCap)]);
figure;
plot(zaman);
figure;
plot(gbestcost);