function LeadershipAnalyzer(inputDir, post_xls, nomi_xls)

%% Set up a default leadership data path
if ~exist('inputDir', 'var') || isempty(inputDir), inputDir = ...
    'C:\Users\Young Suk Cho\Box Sync\Research_SpotOn Project\04. Datasets\'; end
if ~exist('data_xls', 'var') || isempty(post_xls), post_xls = '1259 All posts data_preproc.xlsx'; end
if ~exist('nomi_xls', 'var') || isempty(nomi_xls), nomi_xls = '1259 Leadership Nomination Data.xlsx'; end

%% Read all the leadership data files
baseDir = 'C:\Temp\SpotOn\';
global post_num, global post_rawStr, global post_raw;
global nomi_num, global nomi_rawStr, global nomi_raw;
global input_table;
global leaders, global followers, global students;

[post_num, post_rawStr, post_raw] = xlsread([inputDir, post_xls]);
[nomi_num,nomi_rawStr,nomi_raw] = xlsread([inputDir, nomi_xls]);
post_rawStr = strtrim(post_rawStr);
nomi_rawStr = strtrim(nomi_rawStr);

%% Read input raw data
% inputDataProcess();

%% Generate the full version of raw data matrix
[input, labels, vars] = genInputTable();

% Temp: to eliminate the qualitative data
input(:,3:13) = [];
vars(:,3:13) = [];

%% Derive a decision tree
%tree = classregtree(input, labels, 'method', 'classification', ...
%    'names', vars, 'categorical', [3:13 16], 'prune', 'off');

% Temp: To proceed only with the quantitave data
tree = classregtree(input, labels, 'method', 'classification', ...
    'names', vars, 'categorical', [16], 'prune', 'off');
view(tree);
% genDecisionTree(input);

%% Analyze the decision tree
analyzeDecisionTree();

%% Display the results
displayResults();

end