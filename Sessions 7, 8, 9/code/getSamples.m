function [gt] = getSamples(data, chosen_class)
%GETSAMPLES Summary of this function goes here
%   Detailed explanation goes here
subSeq =[];% sequence cuts size(n_ gestures,80) where 80 is 20xXYZV
indices =[];% beg-end frames of each sequence size(n_ gestures)

for i=1:size(data,2)
    if i==12
        continue
    end
    [gest, ngest] = gestureCuts(data(i).X, data(i).Y);
    if gest(1,1)~=chosen_class
        continue
    end
    for j=1:ngest
       subSeq=[subSeq; data(i).X(gest(j,2):gest(j,3),:)];
       indices=[indices size(subSeq,1)];
    end
gt.subSeq=subSeq;
gt.indices=indices;
end

