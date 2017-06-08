function [ D ] = distance( u, v, type)
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here

w=ones(1,20);
w(8)= 2;%left hand
w(12)= 2;%right hand
if type==1
    V=u-v;
    D=sqrt(sqrt(V * V'));
elseif type==2
    D=0;
    for i=1:4:80
        V=u(i:i+3)-v(i:i+3);
        D=D+sqrt(sqrt(V * V'));
    end
    D=D/20;
elseif type==3
    D=1;
    for i=1:4:80
        V=u(i:i+3)-v(i:i+3);
        D=D*sqrt(sqrt(V * V'));
    end
    D=D^(1/20);
elseif type==4
    D=0;
    for i=1:4:80
        V=u(i:i+3)-v(i:i+3);
        D=D+w((i+3)/4)*sqrt(sqrt(V * V'));
    end
    D=D/sum(w);
else
    D=NaN;
end
end

