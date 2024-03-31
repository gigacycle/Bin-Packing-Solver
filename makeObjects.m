function [ obj ] = makeObjects( objCount, maxW )
    empty_obj = struct();
    empty_obj.w = 0;
    empty_obj.id = '';
    for i=1:objCount
        obj(i) = empty_obj;
        obj(i).w = 1+ rand * (maxW -1);
        obj(i).id = i;
    end
end

