function [ tags1, tags2] = classify( data, model, method )
%CLASSIFY Given a model classifies the data for the selected method
%   input: Data- data to be classified
%          Model- Already trained model
%          Method- Slected method for distance
%   Output: 2 Kind of values for the posible taggs
tags1=zeros(1,12);
tags2=zeros(1,12);

for i=1:size(model,2)
    th=model(i).th;
    t=model(i).proto;
    r=data;
    [Dist,D,w]=dtw(t,r,1,method);
    pos=[];
    for j=1:size(w,2)
        pos=[pos w(j).w(1,2)];
    end
    sorted=sort(D(end,D(end,:)<th));
    best=sorted(1:5);
    %posibles=t(D(end, t)<th);
    tags2(i)=mean(best(best<th));
    tags1(i)=sum(D(end,pos)<th);
end
tags1=tags1/sum(tags1);



end

