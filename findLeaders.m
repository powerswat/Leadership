function [leaders, followers] = findLeaders(nomi_rawStr)

% Count the number of votes each individual obtained.
all_nomination = nomi_rawStr(2:end, 6);
leader_cand = unique(all_nomination);

num_leaders = length(leader_cand);
votes = zeros(num_leaders, 1);
for i=1:num_leaders
    votes(i) = length(find(strcmp(leader_cand(i), all_nomination)));
end

hist_vote = histogram(votes);
count_vec = hist_vote.Values';

% Find the students who got votes more than the average
cut_off = mean(count_vec);
selected_leader_idcs = votes>6;
leaders = leader_cand(selected_leader_idcs);

all_students = union(nomi_rawStr(2:end, 4), nomi_rawStr(2:end, 6));
followers = setdiff(all_students, leaders);

end