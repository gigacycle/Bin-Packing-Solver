function [selected] = bestNeighbour(neighbour)
    for i=1:size(neighbour,2)
        cost(i) = bpCost(neighbour{i});
    end
    [minCost ,indx] = min(cost);
    selected = neighbour{indx};
end