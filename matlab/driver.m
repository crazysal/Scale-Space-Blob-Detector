%info for user....

clear all;
clc

%%%%%%%%%%%%
%% Pick image
%%%%%%%%%%%%
%'einstein.jpg'; 
%'butterfly.jpg'; 
%'fishes.jpg'; 
%'sunflowers.jpg';
%'bunny.jpg';
%'sun.jpg';
%'grim.jpg';
%'howard.png';
imgFilename = '..\data\butterfly.jpg';
targetImg = imread(imgFilename);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Convert image to gray scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Converting to grey scale by taking mean value of red,green,blue pixel and dividing by maximum     
img_GrayScale = mean(double(targetImg),3)./max(double(targetImg(:)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define parameters for desired implementation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numScales = 15;
sigma = 2;
scaleMultiplier = sqrt(sqrt(2)); %scale multiplication constant  
threshold = 0.0095; %for the double image which is all 0->1

%%%%%%%%%%%%%%
%% Detect blobs
%%%%%%%%%%%%%%

%%slowdown: Increase Kernel Size
scaleSpace_3D_NMS = detectBlobs( img_GrayScale, numScales, sigma, false, scaleMultiplier, threshold ); 

%%speedup: Reduce image size
%scaleSpace_3D_NMS = detectBlobs( img_GrayScale, numScales, sigma, true, scaleMultiplier, threshold );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Display resulting circles at their characteristic scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
radiiByScale = calcRadiiByScale(numScales, scaleMultiplier, sigma);

blobMarkers = retrieveBlobMarkers(scaleSpace_3D_NMS, radiiByScale); 

xPos = blobMarkers(:,1); %col positions
yPos = blobMarkers(:,2); %row positions
radii = blobMarkers(:,3); %radii

%show_all_circles(targetImg, xPos, yPos, radii, 'r', .5); %overlay on original img
show_all_circles(img_GrayScale, xPos, yPos, radii, 'r', .5); %overlay on gray img
