% EWCVT-B algorithm
% Supposed to be faster.

clear all 
close all
clc

input_image =rgb2gray(imread('bear.jpg'));
int_image = int32(input_image);

resized_image = imresize(int_image, [128 128]);

[height width] = size(resized_image);

generators = [54 100 200];
ngenerators = size(generators, 2);

% initial conditions assume we have calculated an arbitary partion of the
% image. And also we have calculated the mean of the clusters and assumed
% them to be the generators
voronoi_tesselations = CVTA(generators, resized_image);
generators = cluster_centroids(resized_image, voronoi_tesselations, generators);
lambda = 0.1;


while(true)
    no_change = false;
    for y = 1 : height
        for x = 1 : width
            edistances = edge_weighted_distance(x, y, resized_image, voronoi_tesselations, generators, lambda);
            
            % find minimal of edistances
            [ne, min_index] = min(edistances);
            
            % transfer pixel from current cluster to minimal cluster
            set_pixels = zeros(1, ngenerators);
            set_pixels(1, :) = voronoi_tesselations(x, y, :);
            [ne, original_cluster] = max(set_pixels);
            
            
            if(original_cluster ~= min_index)
                
                % change flag
                no_change = true;
                
                % yes we need a change of clusters. so set and reset
                % appropriately.
                voronoi_tesselations(x, y, original_cluster) = 0;
                voronoi_tesselations(x, y, min_index) = 1;
                
                % calculate the new generators
                generators = cluster_centroids(resized_image, voronoi_tesselations, generators);
            end
        end
    end
    
    % check only after all pixels are processed
    if(no_change == false)
        break;
    end
    
end
