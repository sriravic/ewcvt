% EWCVT algorithm
clear all
close all
clc

input_image = imread('noise2.jpeg');
int_image = int32(rgb2gray(input_image));

%given a set of generators calculate the voronoi tesslations initially
generators = [61 200];
% generators(1,1,:) =[0  0 200];
% generators(1,2,:) =[70 140 80];
% generators(1,3,:) =[40 200 140];
% generators(1,4,:) =[10   0  0];
% generators(1,5,:) =[255 225 200];

resized_image = imresize(int_image, [128 128]);
%resized_image = int_image;

[voronoi_tesselations] = CVTA(generators, resized_image);




% now that we have the voronoi tesselations, we can proceed ahead to
% calculate the actual EWCVTA algorithm

while(true)
    % get the new generators from centroids using equation 31 in paper..!!
    new_generators = cluster_centroids(resized_image, voronoi_tesselations, generators);
    
    % step 2:
    new_voronoi_tesselations = EWVT(resized_image, voronoi_tesselations, new_generators);
    
    % step 3:
    % check if new_voronoi_tesselations == voronoi_tesselations. 
    if(new_voronoi_tesselations == voronoi_tesselations)
        break;
    else
        voronoi_tesselations = new_voronoi_tesselations;
        generators = new_generators;
        continue;
    end
end

% Algo done..!!!
















