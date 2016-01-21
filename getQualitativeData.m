function [qualitative_data] = getQualitativeData()

% Collect the qualitative data for each user

global nomi_num, global nomi_rawStr;
global post_num, global post_rawStr;
global students;

% Qualitative data matrix collected from the nomination data
qual_data = nomi_num(1:end-1,12:23);

nomi_names = nomi_rawStr(2:end,6);
post_names = post_rawStr(2:end,12);

qualitative_data = zeros(size(post_names,1),12);

row_students = size(students, 1);

for i=1:row_students
    curr_nomi_idcs = find(strcmp(nomi_names, students(i)));
    curr_name_idcs = find(strcmp(post_names, students(i)));
    
    if length(curr_nomi_idcs) == 1
        qual_vec = nomi_num(curr_nomi_idcs,12:23);
    else
        qual_vec = sum(nomi_num(curr_nomi_idcs,12:23))>0;
    end
    
    qualitative_data(curr_name_idcs,:) ...
            = repmat(qual_vec, length(curr_name_idcs), 1);        
end

% Find and remove zero columns
zero_cols = max(qualitative_data)==0;
qualitative_data(:, zero_cols) = [];

end