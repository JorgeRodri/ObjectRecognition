% Main program for the OR course for gesture recognition
% Author: Jorge Rodriguez

% load the data
[data, tagset]=loadAll();

%show the results as an image for dtw algorithm
%same gesture
gest=10; % select the gesture to compare
gt = getSamples(data, gest);

t=gt.subSeq(gt.indices(5):gt.indices(6),:);
r=gt.subSeq(1:gt.indices(5),:);
[Dist,D,w]=dtw(t,r,1,1);
figure(1);
plot_error( D, w, gt.indices(1:5), 1)

%diffrent gestures
gest=8; %select the gesture to compare
gt1 = getSamples(data, gest);

t=gt.subSeq(gt.indices(4):gt.indices(5),:);
r=gt2.subSeq(1:gt2.indices(5),:);
[Dist,D,w]=dtw(t,r,1,1);
figure(2);
plot_error( D, w, gt2.indices(1:5), 1)

% select the parameters
method=1; % select the distance method 1 euclidean, 2 euclidean with mean, 3 euclidean geometric mean and 4 weighted euclidean
tags_type=2; % select 1 for threshold or 2 for threshold and the 10 best results


% train the model

train_data=data(1:500);
for i=1:12
    [prototype, th] = train_model(data, i,method);
    model(i).proto=prototype;
    model(i).th=th;
end

% test the model
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

if tags_type==1
    accuracy = sum(diag(conf_matrix1))/sum(sum(conf_matrix1));
    a=nanmean(precision(conf_matrix1));
    b=mean(recall(conf_matrix1));
    F1score= 2*a*b/(a+b);
    categories={'Gest1','Gest2','Gest3','Gest4','Gest5','Gest6','Gest7','Gest8','Gest9','Gest10','Gest11','Gest12'};
    T = array2table(conf_matrix1, 'RowNames',categories,'VariableNames',categories);
    
elseif tags_type==2
    accuracy = sum(diag(conf_matrix2))/sum(sum(conf_matrix2));
    a=nanmean(precision(conf_matrix2));
    b=mean(recall(conf_matrix2));
    F1score= 2*a*b/(a+b);
    categories={'Gest1','Gest2','Gest3','Gest4','Gest5','Gest6','Gest7','Gest8','Gest9','Gest10','Gest11','Gest12'};
    T = array2table(conf_matrix2, 'RowNames',categories,'VariableNames',categories);
end


T
[tags_type,method,b, a, accuracy, F1score]