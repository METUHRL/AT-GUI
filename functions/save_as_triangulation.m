function trep = save_as_triangulation(struct_data)
data = load_content(struct_data);
field_num = length(data);
field_num_array = zeros(field_num,2);
for i =1:field_num
    field_num_array(i,:) = size(data{i,1});
end

for k=1:field_num
    if field_num_array(k,2) == 3 
        if field_num_array(k,1) == max(field_num_array(:,1)) 
            face = data{k};
        else
            pts = data{k};
        end
    elseif field_num_array(k,1) == 3 
        if field_num_array(k,2) == max(field_num_array(:,2)) 
            face = data{k}.';
        else
            pts = data{k}.';
        end  
    end
end
num_of_pts = max(size(pts));
unique_face = unique(face);
if unique_face ~= (1:num_of_pts)' 
   error_msg = "this triangulation does not belong to this pts";
   error(error_msg);
else
    trep = TriRep(face,pts);
end
end


