function [ bp ] = mutation( binpack, bpCap )
    %cost = bpCost(binpack);
    objSet = getObjects(binpack);
    mp1 = fix(1 + rand * (size(objSet,2)-1));
    mp2 = fix(1 + rand * (size(objSet,2)-1));
    tmp = objSet(mp1);
    objSet(mp1) = objSet(mp2);
    objSet(mp2) = tmp;
    newBinpack = setObjects(objSet, bpCap);
  %  if (bpCost(newBinpack) <= cost)
        bp = newBinpack;
  %  else
       % bp = binpack;
  %  end
end

