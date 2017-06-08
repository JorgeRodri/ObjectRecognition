function [Dist,D,final_tracks]=dtw(t,r, th,method)
%Dynamic Time Warping Algorithm
% Outputs
%Dist is unnormalized distance between t and r
%D is the accumulated distance matrix
%k is the normalizing factor
%w is the optimal path
% Inputs:
%t is the vector you are testing against
%r is the vector you are testing
%th Selects if is 1vs1 it th=0, or finding a sequence inside another one
%bigger if th=1
%method is the kind of distance
N=size(t,1);
M=size(r,1);
%for n=1:N
%    for m=1:M
%        d(n,m)=(t(n)-r(m))^2;
%    end
%end
%d=(repmat(t(:),1,M)-repmat(r(:)',N,1)).^2; %this replaces the nested for loops from above Thanks Georg Schmitz 

D=zeros(N,M);
D(1,1)=0;
if th==0
    for n=2:N
        D(n,1)=inf;
    end
    for m=2:M
        D(1,m)=inf;
    end

else
    for n=2:N
        D(n,1)=inf;
    end
    for m=2:M
        D(1,m)=0;
    end
end

for n=2:N
    for m=2:M
        D(n,m)=distance(t(n,:),r(m,:),method)+min([D(n-1,m),D(n-1,m-1),D(n,m-1)]);
    end
end



if th==0
    Dist=D(N,M);
    n=N;
    m=M;
    w=[];
    w(1,:)=[N, M];

    while ((n+m)~=2)
         if (n-1)==0
             m=m-1;
         elseif (m-1)==0
             n=n-1;
         else 
           [values,number]=min([D(n-1,m),D(n,m-1),D(n-1,m-1)]);
           switch number
           case 1
              n=n-1;
           case 2
             m=m-1;
           case 3
             n=n-1;
             m=m-1;
           end
         end
            w=cat(1,w,[n,m]);
        end
final_tracks=w;

else
    %buscar todos los caminos
    ini_step=extrema(D(N,:));
    %ini_step=[];
    %for index=1:M
    %    if D(N,index)<th
    %        ini_step=[ini_step index];
    %    end
    %end
    
    Dist=[];
    for ini=1:size(ini_step,2)
        n=N;
        m=ini_step(1,ini);
        w=[N, m];
        Dist=[Dist D(n,m)];

        while (n~=1)
            if (m-1)==0
                n=n-1;
            else 
              [values,number]=min([D(n-1,m),D(n,m-1),D(n-1,m-1)]);
              switch number
              case 1
                n=n-1;
              case 2
                m=m-1;
              case 3
                n=n-1;
                m=m-1;
              end
            end
            w=[w; [n,m]];
        end
        final_tracks(ini).w=w;
    end
end
end