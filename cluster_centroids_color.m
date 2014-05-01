% Function to calculate the cluster mean using formula (31) in paper !!

function [wl] = cluster_centroids_color(input_image, voronoi_tesselations, generators)
    
    [height width channel] = size(input_image);
    ngenerators = size(generators, 2);
    sumsr = zeros(1, ngenerators);
    sumsg = zeros(1, ngenerators);
    sumsb = zeros(1, ngenerators);
    
    for y = 1 : height
        for x = 1 : width
            set_pixels = zeros(1, ngenerators);
            set_pixels(1, :) = voronoi_tesselations(x, y, :);
            [ne, original_cluster] = max(set_pixels);
            
            sumsr(1, original_cluster) = sumsr(1, original_cluster) + input_image(x, y,1);
            sumsg(1, original_cluster) = sumsg(1, original_cluster) + input_image(x, y,2);
            sumsb(1, original_cluster) = sumsb(1, original_cluster) + input_image(x, y,3);
        end
    end
    
    % count the number of pixels per cluster
    count = zeros(1, ngenerators);
    for i = 1 : ngenerators
        count(1, i) = sum(sum(voronoi_tesselations(:, :, i)));
    end
    
    w_intermediater = sumsr ./ count;   
    w_intermediateg = sumsg ./ count;   
    w_intermediateb = sumsb ./ count;   
    wlr = round(w_intermediater);
    wlg = round(w_intermediateg);
    wlb = round(w_intermediateb);
    wl(:,:,1)=wlr;
    wl(:,:,2)=wlg;
    wl(:,:,3)=wlb;
end
