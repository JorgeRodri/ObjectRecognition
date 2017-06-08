% Main program for the OR course for gesture recognition
% Author: Jorge Rodriguez

%% loading
[data, tagset]=loadAll();
    
%% ground truth
%[gest, ngest] = gestureCuts(data(8).X, data(8).Y);
gt = getSamples(data, 10);

%% matchng
t=gt.subSeq(1:gt.indices(1));
r=gt.subSeq(gt.indices(1)+1:gt.indices(2));
%r=t;
[Dist,D,w]=dtw(t',r',0);
plot_error( D, w, data(3).Y, 0)
%%

[gest, ngest] = gestureCuts(data(3).X, data(3).Y);

t=gt.subSeq(1:gt.indices(1),:);
r=data(3).X(gest(1,2):gest(1,3),:);
[Dist,D,tracks]=dtw(t,r,0);
plot_error( D, tracks, data(3).Y, 0)
%%
[gest, ngest] = gestureCuts(data(3).X, data(3).Y);
t=gt.subSeq(1:gt.indices(1),:);
r=data(4).X;
[Dist,D,tracks]=dtw(t,r,1);
plot_error( D, tracks, data(4).Y,1)

%% different gestures  
gt = getSamples(data, 10);
gt2 = getSamples(data, 8);

t=gt.subSeq(gt.indices(4):gt.indices(5),:);
r=gt2.subSeq(1:gt2.indices(5),:);
[Dist,D,w]=dtw(t,r,1,1);
plot_error( D, w, gt2.indices(1:5), 1)
%D(end,gt2.indices(1:end))
%% same gesture 
gt = getSamples(data, 10);

t=gt.subSeq(gt.indices(end-1):end,:);
r=gt.subSeq(1:gt.indices(end-1),:);
[Dist,D,w]=dtw(t,r,1);
%plot_error( D, w, gt.indices(1:end-2), 1)
%%
gt = getSamples(data, 10);

t=gt.subSeq(gt.indices(end-1):end,:);
r=gt.subSeq(1:gt.indices(end-1),:);
[Dist,D,w]=dtw(t,r,1);
th  = remove_outliers( D(end,gt.indices(1:end-1)));

%%
for i=1:1
method=i
train_data=data(1:500);
for i=1:12
    [prototype, th] = train_model(data, i,method);
    model(i).proto=prototype;
    model(i).th=th;
end

test_data=data(501:end);
conf_matrix1=zeros(12);
conf_matrix2=zeros(12);
for i=1:size(test_data,2)
    [gest, ngest] = gestureCuts(test_data(i).X, test_data(i).Y);
    [taggs1,taggs2]=classify(test_data(i).X, model,method);
    real_tag=gest(1);
    [value, indice1]=max(taggs1);
    [value, indice2]=min(taggs2);
    conf_matrix1(indice1,real_tag)=conf_matrix1(indice1,real_tag)+1;
    conf_matrix2(indice2,real_tag)=conf_matrix2(indice2,real_tag)+1;
end




accuracy = sum(diag(conf_matrix1))/sum(sum(conf_matrix1));
a=nanmean(precision(conf_matrix1));
b=mean(recall(conf_matrix1));
F1score= 2*a*b/(a+b);

[1,i,b, a, accuracy, F1score]

accuracy = sum(diag(conf_matrix2))/sum(sum(conf_matrix2));
a=mean(precision(conf_matrix2));
b=mean(recall(conf_matrix2));
F1score= 2*a*b/(a+b);

[2,i,b, a, accuracy, F1score]

end