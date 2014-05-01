function cluster=CVTA(generators,I)

[m n] = size(I);        %Size of input image
 
[width height]  = size(generators);%Size of the generators
  
cluster = zeros([m,n,height]);  %Clustering variable
 

        for i=1:m
            for j=1:n
                temp=zeros(width,height);
                for l=1:height
                    wl=generators(1,l);
                    temp(1,l) = abs(I(i,j)-wl);
                end
                    [c,index] = min(temp);
                    cluster(i,j,index)=1;
            end
        end
    
