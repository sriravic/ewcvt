function [cluster]=CVTA_color(generators,I)

[m n p] = size(I);      %Size of input image
 
[width height g3]  = size(generators);  %Size of the generators
  
cluster = zeros([m,n,height]);   %Clustering variable
 

        for i=1:m
            for j=1:n
                temp=zeros(width,height);
                for l=1:height
                    
                        wl1=generators(1,l,1);
                        wl2=generators(1,l,2);
                        wl3=generators(1,l,3);
                        
                        temp(1,l) = abs(I(i,j,1)-wl1)+abs(I(i,j,2)-wl2)+abs(I(i,j,1)-wl3);
                   
                end
                    [c,index] = min(temp);
                    cluster(i,j,index)=1;
            end
        end
