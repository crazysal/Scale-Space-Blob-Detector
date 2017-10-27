function [ scaleSpace_3D_NMS ] = detectBlobs( img_GrayScale, numScales, sigma, bShouldDownsample, scaleMultiplier, threshold )

% Define Parameters
[h, w] = size(img_GrayScale); 
imgSize = [h,w];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convolve img w/ scale-normalized Laplcaian at several scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate the various scales by applying the filter
disp('Generating Scale Space'); tic;
scaleSpace = generateScaleSpace(img_GrayScale, numScales, sigma, scaleMultiplier, bShouldDownsample);
disp('Finished generating scale space'); toc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2D Non Max Suprresion for Each Individiaul Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%first do nonmaximum suppression in each 2D slice separately
scaleSpace_2D_NMS = zeros(h,w,numScales);
for i = 1:numScales
    scaleSpace_2D_NMS(:,:,i) = nms_2D(scaleSpace(:,:,i),1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3D Non Max Suppression Between Neighboring Scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scaleSpace_3D_NMS = nms_3D(scaleSpace_2D_NMS, scaleSpace, numScales);

%%%%%%%%%%%
% Threshold
%%%%%%%%%%%

threshBinaryFlag = scaleSpace_3D_NMS > threshold;
scaleSpace_3D_NMS = scaleSpace_3D_NMS .* threshBinaryFlag;

end