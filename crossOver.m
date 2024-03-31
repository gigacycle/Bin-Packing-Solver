function [ childs ] = crossOver( parrentA,parrentB,bpCap )
    objSet1 = getObjects(parrentA);
    objSet2 = getObjects(parrentB);
    n = min(size(objSet1,2),size(objSet2,2));
    crossPoint1= 1 + floor(rand * (n-1));
    crossPoint2= 1 + floor(rand * (n-1));
    Arrange1 = [objSet1(1:crossPoint1) objSet2(crossPoint1+1:end)];
    Arrange2 = [objSet2(1:crossPoint1) objSet1(crossPoint1+1:end)];
    [Arrange1, Arrange2] = swapDuplicates(Arrange1, Arrange2, crossPoint1);
    Arrange3 = [objSet1(1:crossPoint2) objSet2(crossPoint2+1:end)];
    Arrange4 = [objSet2(1:crossPoint2) objSet1(crossPoint2+1:end)];
    [Arrange3, Arrange4] = swapDuplicates(Arrange3, Arrange4, crossPoint2);
    childs{1,1} = setObjects(Arrange1, bpCap);
    childs{2,1} = setObjects(Arrange2, bpCap);
    childs{3,1} = setObjects(Arrange3, bpCap);
    childs{4,1} = setObjects(Arrange4, bpCap);
end
