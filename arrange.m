function [bp]=arrange(objects,bpCount, bpCap)
    % Sakhtare Koole Poshtie Khali
    empty_bp = struct();
    empty_bp.ca = bpCap;
    empty_bp.obj = cell(1,bpCap);
    empty_bp.objCount = 0;
    cnt = 1;
    bp(cnt) = empty_bp;
    selectionArea = 1:size(objects,2);
    i=1;
    %Chidane Ashya dar Koole Poshti-ha
    while (i<=size(objects,2))
        %Bar-resie Zarfiate Har Koole Poshti
        selected = fix(1 + rand * (size(selectionArea,2)-1));
        if (objects(selectionArea(selected)).w<=bp(cnt).ca)
            bp(cnt).objCount=bp(cnt).objCount+1;
            bp(cnt).obj{bp(cnt).objCount} = objects(selectionArea(selected));
            bp(cnt).ca = bp(cnt).ca - objects(selectionArea(selected)).w;
            selectionArea(selected)=[];
        else
            cnt=cnt+1;
            i = i - 1;
            %Bar-resie Tedade Koole Poshti-ha
            if (cnt>bpCount)
                break;
            end
            bp(cnt) = empty_bp;
        end
        i = i+1;
    end
end