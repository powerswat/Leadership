function [num_students, post_num_students, sum_degree_students, mean_degree_students, ...
    mean_len_students, mean_uniq_len_students] ...
    = analysisOnStudents(students, post_rawStr, post_num)

num_students = length(students);
post_num_students = zeros(num_students,1);
sum_degree_students = zeros(num_students,1);
mean_degree_students = zeros(num_students,1);
mean_len_students = zeros(num_students,1);
mean_uniq_len_students = zeros(num_students,1);

% Generate response time for every student
[resp_times] = genRespTime(students, post_rawStr, post_num);

% Generate statistical data over all the students
for i=1:num_students
    
    % Indices of the current student's postings
    posting_idcs = find(strcmp(post_rawStr(2:end, 12), students(i)));
    
    % Iterates through all the postings made by the current user
    if ~isempty(posting_idcs)
        
        num_leader_words = zeros(length(posting_idcs),1);
        leader_word_sets = cell(length(posting_idcs),1);
        num_leader_uniq_words = zeros(length(posting_idcs),1);
        leader_uniq_word_sets = cell(length(posting_idcs),1);
        
        num_word_len = length(num_leader_words);
        for j=1:num_word_len
            % A bag of word used by each leader
            leader_word_sets{j} = strsplit(char( ...
                                        post_rawStr(posting_idcs(j),17)))';
                                    
            % A set of word used by each leader
            leader_uniq_word_sets{j} = unique(strsplit(char( ...
                                        post_rawStr(posting_idcs(j),17))))';
            
            num_leader_words(j) = length(leader_word_sets{j});
            num_leader_uniq_words(j) = length(leader_uniq_word_sets{j});
        end
        
        % Number of average words that the current leader used
        mean_len_students(i) = mean(num_leader_words);
        
        % Average number of unique words that the current leader used
        mean_uniq_len_students(i) = mean(num_leader_uniq_words);
        
        
        % Number of postings the current leader made
        post_num_students(i) = length(posting_idcs);
        
        
        % Average sum of degrees of each thread the current leader has
        sum_degree_students(i) = sum(post_num(posting_idcs,16));
        
        % Average degree of each thread the current leader has
        mean_degree_students(i) = mean(post_num(posting_idcs,16));
    end
end


end