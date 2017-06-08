function [ indexes, values] = extrema( v )
%EXTREMA Extract the local minima of an array
%   V vector or array with real numbers
% indexes is the position of the minimas
% values contains the actual values of the minimas
indexes=[];
dv=sign(diff(v));
previous=dv(1,1);
n=size(v, 2)-1;
for i=2:n
    if dv(1,i)>0 & previous<0
        indexes=[indexes i];
    end
    previous=dv(1,i);
end
indexes=[indexes n+1];
values=v(indexes);
    

end

