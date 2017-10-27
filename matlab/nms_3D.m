function [ scaleSpace_3D_NMS ] = nms_3D( scaleSpace_2D_NMS, originalScaleSpace, numScales )
%NMS_3D Summary of this function goes here


[h,w] = size(scaleSpace_2D_NMS(:,:,1));
maxVals_InNeighboringScaleSpace = scaleSpace_2D_NMS;
for i = 1:numScales
    if i == 1
        lowerScale = i;
        upperScale = i+1;
    elseif i < numScales
        lowerScale = i-1;
        upperScale = i+1;
    else
        lowerScale = i-1;
        upperScale = i;
    end
    %each row and column holds the maximum value at that row and col from 
    %the neighboring scale space... 
    %ie: the maximum of the value at pix x,y in the scale space above, 
    %current and below... so neighboring scales will end up with the same
    %values at many row and col positions... this is an intermediate calc
    maxVals_InNeighboringScaleSpace(:,:,i) = max(maxVals_InNeighboringScaleSpace(:,:,lowerScale:upperScale),[],3);
end

%mark every location where the max value is the actualy value from that
%scale with a 1, and a 0 otherwise. (Binary flag)
originalValMarkers = maxVals_InNeighboringScaleSpace == originalScaleSpace;
%only keep the max vals that were actually from those locations
scaleSpace_3D_NMS = maxVals_InNeighboringScaleSpace .* originalValMarkers;

end
