function [ best ] = RANSAC(numMatches, xa, xb, M, N, epsilon)
%RANSAC algorithm
%   Detailed explanation goes here
nmax=0;

for i=1:M,
    subset = vl_colsubset(1:numMatches, N);
    d = xb(1:2,subset) - xa(1:2,subset);
    p = mean(d,2);
    xb_ = zeros(size(xb));
    for i=1:numMatches,
        xb_(:,i) = xa(:,i) + p;
    end
    n = 0;
    for i=1:numMatches,
        e = xb_(:,i) - xb(:,i);
        if (norm(e) < epsilon), n = n + 1; end
    end
    if n>nmax, nmax=n; best=p; end
end   
end

