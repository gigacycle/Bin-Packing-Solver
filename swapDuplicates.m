function [ output1, output2 ] = swapDuplicates( input1, input2, crossPoint )
    a = [input1.id];
    b = [input2.id];
    dupIndex1 = [];
    dupIndex2 = [];
    cnt =1;
    for i=1:crossPoint
        for j=crossPoint+1:size(a,2)
            if (a(i) == a(j))
                dupIndex1(cnt) = j;
                cnt = cnt+1;
            end
        end
    end
    cnt =1;
    for i=1:crossPoint
        for j=crossPoint+1:size(b,2)
            if (b(i) == b(j))
                dupIndex2(cnt) = j;
                cnt = cnt+1;
            end
        end
    end
    output1 = input1;
    output2 = input2;
    if (size(dupIndex1,2)>0)
        for i=1:size(dupIndex1,2)
            tmp = output1(dupIndex1(i));
            output1(dupIndex1(i)) = output2(dupIndex2(i));
            output2(dupIndex2(i)) = tmp;
        end
    end
end

