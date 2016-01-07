function textLeaderAnalyzer(inputDir, post_xls, nomi_xls)

%% Set up a default leadership data path
if ~exist('inputDir', 'var') || isempty(inputDir), inputDir = ...
    'C:\Users\Young Suk Cho\Box Sync\Research_SpotOn Project\04. Datasets\'; end
if ~exist('data_xls', 'var') || isempty(post_xls), post_xls = '1259 All posts data_preproc.xlsx'; end
if ~exist('nomi_xls', 'var') || isempty(nomi_xls), nomi_xls = '1259 Leadership Nomination Data.xlsx'; end

%% Read all the leadership data files
baseDir = 'C:\Temp\SpotOn\';
[post_num, post_rawStr, post_raw] = xlsread([inputDir, post_xls]);
[nomi_num,nomi_rawStr,nomi_raw] = xlsread([inputDir, nomi_xls]);
post_rawStr = strtrim(post_rawStr);
nomi_rawStr = strtrim(nomi_rawStr);

%% Classify the students into two groups (Leaders, Followers)
% Leader: Students who obtained the number of votes more than the average
% Follower: Students who are not classified as leaders
[leaders, followers] = findLeaders(nomi_rawStr);

%% Analysis on leaders
[num_leaders, post_num_leaders, sum_degree_leaders, mean_degree_leaders, ...
    mean_len_leaders, mean_uniq_len_leaders] ...
    = analysisOnStudents(leaders, post_rawStr, post_num);

%% Analysis on followers
[num_followers, post_num_followers, sum_degree_followers, mean_degree_followers, ...
    mean_len_followers, mean_uniq_len_followers] ...
    = analysisOnStudents(followers, post_rawStr, post_num);


%% Comparison of the average (avg) / median (med) / standard deviation (std)
%   number of postings between the leaders and the followers
[avg_post_num_leaders, med_post_num_leaders, std_post_num_leaders, ...
    avg_post_num_followers, med_post_num_followers, std_post_num_followers] ...
    = genCompBasicStats(post_num_leaders, post_num_followers, ...
                    'number of postings of leaders / followers');

%% Comparison of the avg / med / std sum of degrees between the leaders and the followers
[avg_sum_degree_leaders, med_sum_degree_leaders, std_sum_degree_leaders, ...
    avg_sum_degree_followers, med_sum_degree_followers, std_sum_degree_followers] ...
    = genCompBasicStats(sum_degree_leaders, sum_degree_followers, ...
                    'sum of degrees of leaders'' / followers'' postings');

%% Comparison of the avg / med / std degrees between the leaders and the followers
[avg_degree_leaders, med_degree_leaders, std_degree_leaders, ...
    avg_degree_followers, med_degree_followers, std_degree_followers] ...
    = genCompBasicStats(mean_degree_leaders, mean_degree_followers, ...
                    'degrees of leaders'' / followers'' postings');

%% Comparison of the avg / med / std length of each posting of the leaders and the followers
[avg_len_leaders, med_len_leaders, std_len_leaders, ...
    avg_len_followers, med_len_followers, std_len_followers] ...
    = genCompBasicStats(mean_len_leaders, mean_len_followers, ...
                    'length of leaders'' / followers'' postings');

%% Comparison of the avg / med / std number of unique words used by the leaders and the followers
[avg_unique_words_leaders, med_unique_words_leaders, std_unique_words_leaders, ...
    avg_unique_words_followers, med_unique_words_followers, std_unique_words_followers] ...
    = genCompBasicStats(mean_uniq_len_leaders, mean_uniq_len_followers, ...
                    'number of unique words used by leaders / followers');
                                
%% Comparison of the avg / med / std response time taken by the leaders and the followers

                
%% Form a decision tree based on the derived statistics above
[dec_tree] = decisionTree(leaders, followers, post_num, post_rawStr);

end

function [avg1, med1, std1, avg2, med2, std2] ...
        = genCompBasicStats(input_data1, input_data2, message)

avg1 = mean(input_data1);
avg2 = mean(input_data2);
fprintf(['Average ' message '\n'])
fprintf([': ' num2str(avg1) ' / ' num2str(avg2) '\n'])

med1 = median(input_data1);
med2 = median(input_data2);
fprintf(['Median ', message '\n'])
fprintf([': ' num2str(med1) ' / ' num2str(med2) '\n'])

std1 = std(input_data1);
std2 = std(input_data2);
fprintf(['Stdev ' message '\n'])
fprintf([': ' num2str(std1) ' / ' num2str(std2) '\n\n'])

end
