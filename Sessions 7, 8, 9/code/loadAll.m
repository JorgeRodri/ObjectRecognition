function [ data, tagset ] = loadAll()
%LOADALL First task for the OR couse practical 3, gesture detection
%   No argument, read and loads the images
data=[];
tagset={};
i=0;
df=dir('../data/*.csv');
for di=1:numel(df)
    i=i+1;
	[X,Y,ts]=load_file(strtok(df(di).name,'.'));
	assert(size(X,1)==size(Y,1));
    obj.X=X;
    obj.Y=Y;
    data=[data obj];
    tagset{i}=ts;
end
end

