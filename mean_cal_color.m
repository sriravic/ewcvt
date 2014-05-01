function mean_valuei =mean_cal_color(cluster,input_image)

[m n]=size(cluster);
mean_value = zeros(m,n);

for k=1:m
    for l=1:n
    p=cluster(k,l);
    mean_sum=0;
       if(p==1) 
            for i=1:m
                for j=1:n
                mean_sum = mean_sum + (input_image(i,j,1)-input_image(k,l,1))^2 + (input_image(i,j,2)-input_image(k,l,2))^2 + (input_image(i,j,3)-input_image(k,l,3))^2;
                end
            end
       else
           mean_sum=bitmax;
       end
        mean_value(k,l)=mean_sum;
    end

end
   
[value1,index1]=min(mean_value);
[value2,index2]=min(min(mean_value));
y=index2;
x=index1(index2);

mean_valuei = input_image(x,y,:);


       
