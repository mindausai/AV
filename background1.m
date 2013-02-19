function outimage = background1()

files = dir('images/*.jpg');

namelist = {files(:).name}'; % from dir output

image1 = myjpgload(namelist{1},0);
listofvectors = zeros(size(100));




for f = 1:99
   
   file = myjpgload(namelist{f},0);
   fileslist{f} = file;
   
    
end

[H,W] = size(image1(:,:,1));

outimage = image1;
for k = 1 : 3
for i = 1 : H
   
    for j = 1 : W
        indi = 1;
        for f = 1: 99
            if (f <= 15)
                
        image = fileslist{f};
        vector = image(i,j,k);
        listofvectors(indi) = vector;
        indi = indi+1;
            end
            
            if (f >= 40 && f <= 45)
                
        image = fileslist{f};
        vector = image(i,j,k);
        listofvectors(indi) = vector;
        indi = indi+1;
            end
        
            
            
            if (f >= 75)
                
        image = fileslist{f};
        vector = image(i,j,k);
        listofvectors(indi) = vector;
        indi = indi+1;
        
            end
        end
        
        
      
        
        median1 = median(listofvectors);
        outimage(i,j,k) = median1;
    end
   

end

end


for c = 1 : 3
    background = outimage(:,:,c);
    median1 = median(background(:));
    deviation = std2(background(:));
    for i = 1 : H
        for j = 1 : W
            if (outimage(i,j,c) > (median1+deviation))
                
                outimage(i,j,c) = median1;
            end
            
        end
    end
end



end



