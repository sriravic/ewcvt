% Algorithm EWVT : Edge Weighted Voronoi Tesselation
% Returns a set of voronoi clusters for a given generators (D(l)')

function [new_voronoi_tesselations] = EWVT(input_image, voronoi_tesselations, generators)
    
    [height width] = size(input_image); 
    ngenerators = size(generators, 2)
    lambda = 0.1;
    
    while(true)
        
        any_change = false;
        for y = 1 : height
            for x = 1 : width
                edistances = edge_weighted_distance(x, y, input_image,voronoi_tesselations, generators, lambda);
                
                % now find the min index of edistances
                [ne, min_index] = min(edistances);
                
                % Check in which cluster it was originally in and set that to zero
                % and transfer it to the new cluster by putting a 1 in the
                % appropriate cluster.
                % this can also be done by checking if original == same
                set_pixels = zeros(1, ngenerators);
                set_pixels(1, :) = voronoi_tesselations(x, y, :);
                [ne, original_cluster] = max(set_pixels);
                
                
                if(original_cluster ~= min_index)
                    % yes we need a change of clusters. so set and reset
                    % appropriately.
                    voronoi_tesselations(x, y, original_cluster) = 0;
                    voronoi_tesselations(x, y, min_index) = 1;
                    any_change = true;
                end
            end
        end
        
        if(any_change == false)
            break;
        end
    end
    
    % copy the new voronoi tesselations and return them back
    new_voronoi_tesselations = voronoi_tesselations;
end
