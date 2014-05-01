function result(cluster)

size =128;
output=uint8(zeros(size,size,3));
for i=1:size
    for j=1:size;
    if(cluster(i,j,1)==1)
    output(i,j,1)=255;
    end
    if(cluster(i,j,2)==1)
    output(i,j,2)=255;
    end
%     if(cluster(i,j,3)==1)
%     output(i,j,3)=255;
%     end
    end
end


figure,imshow(output);

imwrite(output,'night_cvt.jpg','jpg');
