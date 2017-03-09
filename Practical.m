%Laboratory for Object Recognition
%Jorge Rodriguez Molinuevo 
%% install sift and add imaage directory

run('vlfeat-0.9.16/toolbox/vl_setup');
path='TPROJECT/'
addpath(path)

%% Main descriptors
%SIFT=vl_sift(I)
%SURF=detectSURFFeatures(I);
%HoG = extractHOGFeatures(I)
%Harris=detect HarrisFeatures(I);[features, valid_corners] = extractFeatures(I, corners);


I=imread('TIPROJECT/baboon.bmp');
try 
    im=rgb2gray(I);
catch
    im=I;
end

SIFT =vl_sift(single(im));%,'PeakThresh', 10);
ptSURF=detectSURFFeatures(im);
[SURF, valid_points] = extractFeatures(im, ptSURF);
[HoG, hogVisualization] = extractHOGFeatures(im);
corners=detectHarrisFeatures(I);
[features, Harris] = extractFeatures(I, corners);

random=random_selection(SIFT,20);

figure; 
subplot(1,5,1); imshow(I);
subplot(1,5,2); show_keypoints(I,random);
subplot(1,5,3); imshow(I); hold on; plot(valid_points.selectStrongest(20),'showOrientation',true);
subplot(1,5,4); imshow(I); hold on; plot(hogVisualization);
subplot(1,5,5); imshow(I); hold on; plot(Harris);
