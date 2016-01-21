function [input, labels, vars] = genInputTable()

global post_num, global post_rawStr, global post_raw;
global nomi_num, global nomi_rawStr, global nomi_raw;
global leaders, global followers, global students;

%% Classify the students into two groups (Leaders, Followers)
% Leader: Students who obtained the number of votes more than the average
% Follower: Students who are not classified as leaders
% Students: Set of all students
[leaders, followers] = findLeaders(nomi_rawStr);
students = union(leaders, followers);

% Count the number of words and unique words in each post
[num_words_in_each_post, num_uniq_words_in_each] = cntNumWordsInEachPost();

% Collect the qualitative data for each user
[qualitative_data] = getQualitativeData();

% Collect the number of replies and postings for each user
[num_postings, num_replies_posted] = cntNumPostingsReplies();

% Numeric data collected from the orignal posting data
has_group = post_num(:,7);
num_replies_got = post_num(:,14);
depth = post_num(:,16);

% Generate a label column
[labels] = genLabel();

% Integrate all the columns in a single table
input = [num_words_in_each_post, num_uniq_words_in_each, ...
    qualitative_data, num_postings, num_replies_posted, ...
    has_group, num_replies_got, depth];

vars = {'#_wds', '#_unq_wds', ...
   'QUA', 'FAC', 'IND_HEL', 'CON', 'DIV', 'FRE', 'INI', 'CONTRIBUTION', ...
   'MOT', 'NOREASON', 'OTHER', '#_pst', '#_rep_pst', ...
   'has_group', '#_rep_gt', 'depth'};

% Min-Max normalization
input = minMaxNorm(input);

end
