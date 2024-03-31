function [ bp ] = setObjects( objects, bpCap )
   i = 1;
   cnt = 1;
   empty_bp = struct();
   empty_bp.ca = bpCap;
   empty_bp.obj = cell(1,bpCap);
   empty_bp.objCount = 0;
   bp(cnt) = empty_bp;
   while (i<=size(objects,2))
        if (objects(i).w<=bp(cnt).ca)
            bp(cnt).objCount=bp(cnt).objCount+1;
            bp(cnt).obj{bp(cnt).objCount} = objects(i);
            bp(cnt).ca = bp(cnt).ca - objects(i).w;
        else
            cnt=cnt+1;
            i = i - 1;
            bp(cnt) = empty_bp;
        end
        i = i+1;    
   end
end

