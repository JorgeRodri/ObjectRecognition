function [gest, ngest] = gestureCuts(X, Y) %data(i).X, data(i).Y)
%GESTURECUTS Extracts the labels dor the gestures and the frames
%   Input
% X: (T,80) skeletal frames.
% Y: (T,GN) 0/1 encoding of gesture presence.
%
% Output
% gestures: type and action time of each gesture divided
% ngestures: Number of gestures in the sequence
gest=[];
ngest=0;

pos=[];
t=[];
for i=1:size(Y,1)
    if find(Y(i,:))
        pos=[pos find(Y(i,:))];
        t=[t, i];
        ngest=ngest+1;
    end
end

for i=1:(size(t,2)-1)
    gest=[gest; pos(i) t(i) t(i+1)-1];
end
gest=[gest; pos(end) t(end) size(Y,1)];
    

end

