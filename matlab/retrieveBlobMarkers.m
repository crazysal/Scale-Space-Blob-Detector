function [ blobMarkers ] = retrieveBlobMarkers( scaleSpace, radiiByScale  )
%RETRIEVEBLOBMARKERS Summary of this function goes here
    [h,w,numScales] = size(scaleSpace);
    blobMarkers = [];
    for i = 1:numScales
        %find indices in the scale slice where the pixel value != 0
        %(assumes prior thresholding)
        [newMarkerRows, newMarkerCols] = find(scaleSpace(:,:,i));
        
        %create a 3xNumMarkers matrix where row 1 = x pos, row 2 = y pos,
        %row 3 = radius
        newMarkers = [newMarkerCols'; newMarkerRows'];
        newMarkers(3,:) = radiiByScale(i);
        
        %append the calculated positions/radius for this slice to the
        %entire collection (transpose of course)
        blobMarkers = [blobMarkers; newMarkers'];        
    end

end
