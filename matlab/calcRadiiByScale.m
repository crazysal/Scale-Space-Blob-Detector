function [ radiiByScale ] = calcRadiiByScale( numScales, scaleMultiplier, sigma )
%CALCRADIIBYSCALE Summary of this function goes here
    radiiByScale = zeros(1,numScales);
    for i = 1:numScales
        radiiByScale(i) =  sqrt(2) * sigma * scaleMultiplier^(i-1); 
    end
end
