function [container,fnames] = load_content(struct_data,state)

    if nargin < 2
        state = 0; % For recursion 
    end

    fnames = fieldnames(struct_data);
    L = length(fnames);
    container = cell(L,1);

    for i = 1:L
        container{i} = struct_data.(fnames{i});
    end

    is_struct = cellfun(@(x) isstruct(x),container);
    struct_idx = find(is_struct);
    
    if any(struct_idx)
        old_fnames = fnames;
        if ~(isrow(struct_idx)) 
            struct_idx = struct_idx'; 
        end
        for i = struct_idx
            [temp_container, temp_fnames] = load_content(container{i},1);
            container = vertcat(container,temp_container);
            temp_fnames = cellfun(@(x) [old_fnames{i},'->',x],temp_fnames,'UniformOutput',false);
            fnames = vertcat(fnames,temp_fnames);
        end
    end
    
    if state == 0 
        is_struct = cellfun(@(x) isstruct(x),container);
        struct_idx = find(is_struct);
        container = container(~is_struct);
        fnames = fnames(~is_struct);
    end

end