function [num_words, num_uniq_words] = cntNumWordsInEachPost()

% Count the number of words and unique words in each post

global post_rawStr;

[row, col] = size(post_rawStr);
num_words = zeros(row, 1);
num_uniq_words = zeros(row, 1);

for i=2:row
    body = post_rawStr{i,17};
    num_words(i) = length(strsplit(body));
    num_uniq_words(i) = length(unique(strsplit(body)));
end
num_words(1) = [];
num_uniq_words(1) = [];

end