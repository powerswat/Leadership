function [resp_times] = genRespTime(students, post_rawStr, post_num)

num_postings = length(post_rawStr);
num_students = length(students);

timestamps = zeros(num_postings, ...
    length(datevec(post_rawStr(2,18), 'mm/dd/yyyy HH:MM:SS PM')));
elapsed_times = zeros(num_postings, 1);

% Convert the posting time formats to data vector type
for i=2:num_postings
    timestamps(i,:) = datevec(post_rawStr(i,18), 'mm/dd/yyyy HH:MM:SS PM');
end

% Calculate the interval between the current posting and the posting made right
% before that posting
for i=1:num_students
    
    % Indices of the current student's postings
    curr_user_posting_idcs = find(strcmp(post_rawStr(:, 12), students(i)));
    
    % Indices of thread IDs that has the current user's postings
    curr_user_thread_idcs = unique(post_num(curr_user_posting_idcs, 8));
    num_threads = length(curr_user_thread_idcs);
    
    % Iterates over all the threads that have the current user's postings
    for j=1:num_threads
        
        % Find all the timestamps that belong to the same thread ID
        curr_thread_posting_idcs = find(curr_user_thread_idcs(j) == post_num(:,8)) + 1;
        curr_thread_timestamps = post_rawStr(curr_thread_posting_idcs, 18);
        
        if sum(curr_thread_posting_idcs == 1) > 0
            a = 1;
        end
        
        timestamp_vec = datevec(curr_thread_timestamps);
        num_timevecs = size(timestamp_vec,1);
        
        % Calculate elapsed time for all the data elements
        for k=2:num_timevecs
            elapsed_times(curr_thread_posting_idcs(k)) ...
                    = etime(timestamp_vec(k,:), timestamp_vec(k-1,:)); 
        end
    end
end

end