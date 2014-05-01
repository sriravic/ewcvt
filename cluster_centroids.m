% Function to calculate the cluster mean using formula (31) in paper !!

function [wl] = cluster_centroids(input_image, voronoi_tesselations, generators)
    
    [height width] = size(input_image);
    ngenerators = size(generators, 2);
    sums = zeros(1, ngenerators);
    
    for y = 1 : height
        for x = 1 : width
            set_pixels = zeros(1, ngenerators);
            set_pixels(1, :) = voronoi_tesselations(x, y, :);
            [ne, original_cluster] = max(set_pixels);
            
            sums(1, original_cluster) = sums(1, original_cluster) + input_image(x, y);
        end
    end
    
    % count the number of pixels per cluster
    count = zeros(1, ngenerators);
    for i = 1 : ngenerators
        count(1, i) = sum(sum(voronoi_tesselations(:, :, i)));
    end
    
    w_intermediate = sums ./ count;   
    wl = round(w_intermediate);
end
