function  plot_error( D, tracks, Y, seq)
%PLOT_ERROR Summary of this function goes here
%   Detailed explanation goes here

D(D==inf)=1;
D=mat2gray(D);
if size(Y,1)==size(D,2)
    true=find(sum(Y,2));
else
    true=Y;
end

red=D;
blue=D;
green=D;


if seq
    for i=1:size(true,2)
        green(:,true(i))=1;
    end
    for k=1:size(tracks,2)
        for i=1:size(tracks(k).w,1)
            red(tracks(k).w(i,1),tracks(k).w(i,2))=1;
        end
    end
else
    for i=1:size(tracks,1)
        red(tracks(i,1),tracks(i,2))=1;
    end
end

rgbD=cat(3,red, green, blue);

imshow(rgbD)
end

