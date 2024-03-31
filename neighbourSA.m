function [ bp ] = neighbourSA( binpacks, minSpace, bpCap)
%% sort kardane koole poshti-ha bar hasbe zarfiate baghi mande
   [sortedBP,indx] = sort([binpacks.ca]);
%% jaygozarie koole poshti-haye ke zarfiate kami darand
   objCnt=1;
   empty_bp = struct();
   empty_bp.ca = bpCap;
   empty_bp.obj = cell(1,bpCap);
   empty_bp.objCount = 0;
   bp = empty_bp;
   for i=1:size(binpacks,2)
        if (sortedBP(i)<minSpace)
            bp(i) = binpacks(indx(i));
        else
            %jam avarie ashya-e koole haye baghimande
            for j=1:binpacks(indx(i)).objCount
                obj(objCnt) = binpacks(indx(i)).obj{j};
                objCnt=objCnt+1;
            end
        end
   end
%% chidane tasadofie ashya
   selectionArea = 1:size(obj,2);
   cnt = size(bp,2)+1;
   i = 1;
   bp(cnt) = empty_bp;
   while (i<=size(obj,2))
        selected = fix(1 + rand * (size(selectionArea,2)-1));
        if (obj(selectionArea(selected)).w<=bp(cnt).ca)
            bp(cnt).objCount=bp(cnt).objCount+1;
            bp(cnt).obj{bp(cnt).objCount} = obj(selectionArea(selected));
            bp(cnt).ca = bp(cnt).ca - obj(selectionArea(selected)).w;
            selectionArea(selected)=[];
        else
            cnt=cnt+1;
            i = i - 1;
            bp(cnt) = empty_bp;
        end
        i = i+1;    
    end
end