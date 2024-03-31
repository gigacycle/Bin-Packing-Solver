function i=SelectWithProbability(P)
    r=rand;
    C=cumsum(P);
    ii=find(C>=r);
    i=ii(1);
end
