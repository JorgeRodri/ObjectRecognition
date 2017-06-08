function [ p ] = precision( M )
%PRECISION Summary of this function goes here
%   Detailed explanation goes here

p = diag(M) ./ sum(M,2);

end

