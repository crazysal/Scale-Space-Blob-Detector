function [ img_2D_NMS ] = nms_2D( img, radius )
% Extract local maxima  
    neighborhoodSize = 2*radius+1; %size of mask
    domain = ones(3,3);

    img_2D_NMS = ordfilt2(img, neighborhoodSize^2, domain);
end