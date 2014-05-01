% edge weighted distance method

function edistance = edge_weighted_distance(pixel_i, pixel_j, resized_image,voronoi_cluster, generators, lambda)

    % FORMULA USED : n(k) (i,j) = D(k) ^ N(w)(i,j) \ (i,j)
    pixel_i_temp=pixel_i+2;
    pixel_j_temp=pixel_j+2;
    %[width height n] = size(voronoi_cluster);
    ngenerators = size(generators, 2);
    
    
    padded_voronoi_cluster=padarray(voronoi_cluster,[2 2]);
    % default window size is 3x3 for now
    % hard coded !!!!
    %nktilda = zeros(1, generators);
    edistance = zeros(1, ngenerators);
    for l = 1 : ngenerators
        window_matrix = padded_voronoi_cluster( pixel_i_temp-2:pixel_i_temp+2,pixel_j_temp-2:pixel_j_temp + 2, l);
        total = sum(sum(window_matrix));
        if(voronoi_cluster(pixel_i, pixel_j, l) == 1)
            total = total - 1;
        end
        nktilda = 25-total-1;
        edistance(1,l)=sqrt((double(resized_image(pixel_i, pixel_j))-generators(1,l))^2 + 2*lambda*nktilda);
    end
    
    
end

%
%  edistance(1,l)=sqrt((double(resized_image(pixel_i,pixel_j,1))-generators(1,l,1))^2 +(double(resized_image(pixel_i,pixel_j,2))-generators(1,l,2))^2 +(double(resized_image(pixel_i,pixel_j,3))-generators(1,l,3))^2 + 2*lambda*nktilda);
%   
