function [ objects ] = getObjects( binpack )
    n = size(binpack,2);
    k = 1;
    for i=1:n
        for j=1:binpack(i).objCount
            objects(k) = binpack(i).obj{j};
            k = k + 1;
        end
    end
end

