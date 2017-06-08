function [proto,th] = train_model( data, gest,method )
% TRAIN_MODEL array with the prototypes for each gesture and the th
%   data for the dataset already worked


gt = getSamples(data, gest);

t=gt.subSeq(gt.indices(end-1):end,:);
r=gt.subSeq(1:gt.indices(end-1),:);
[Dist,D,w]=dtw(t,r,1,method);
RealDistances=D(end,gt.indices(1:end-1));
th =remove_outliers(RealDistances);
proto=t;
end



