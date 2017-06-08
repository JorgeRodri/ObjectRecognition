function [ th ] = remove_outliers( data )
%REMOVE_OTLIERS eliminates the outliers of a given data
%   data : the data where the outliers will be elminated
%   new_data: data without outliers.

d_s=sort(data);
t=round(0.975*size(d_s,2));
th=d_s(t);
new_data=data(data<=th);
end

