% CVT-B algorithm
clear all
close all
clc

input_image = int32(imread('flowergray.jpg'));
input_image = imresize(input_image, [50 50]);

[width height] = size(input_image);
old_generators = [50 124 100];
new_generators = zeros(size(old_generators));

voronoi_clusters = Calculate_Voronoi_Clusters(input_image, old_generators);
CVT_Old_Energy = zeros(size(old_generators));
for k = 1 : size(old_generators, 2)
    CVT_Old_Energy(k) = Calculate_CVT_Energy(voronoi_clusters, input_image, old_generators(k), k);
end

for l = 1 : size(old_generators, 2)
    for k = 1 : size(old_generators, 2)
        if(l ~= k)
            voronoi_l = voronoi_clusters(:,:,l);
            voronoi_k = voronoi_clusters(:,:,k);
            for y = 1 : width
                for x = 1 : height
                    if(voronoi_l(x, y) == 1)
                        assumed_mean = input_image(x, y);
                        CVT_New_Energy = Calculate_CVT_Energy(voronoi_k, input_image, assumed_mean, 1)
                    end
                end
            end
        end
    end
end
