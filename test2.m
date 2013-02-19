image1 = double(imread('images/00000030.jpg','jpg'));
bg = double(imread('background.jpg','jpg'));

figure(3)
imagesc(image1(:,:,2));

sum = image1(:,:,1)+image1(:,:,2)+image1(:,:,3);

imR = image1(:,:,1);

%im = image - bg;

%im = bwmorph(im(:,:,2),'clean',2);
%figure(5)
%imagesc(im);

%image = image - bg;
 

image1(:,:,1) = image1(:,:,1)./sum; 
image1(:,:,2) = image1(:,:,2)./sum;
image1(:,:,3) = image1(:,:,3)./sum; 

figure(2)
imagesc(image1);
colormap(gray);


sumBg = bg(:,:,1)+bg(:,:,2)+bg(:,:,3);

bg(:,:,1) = bg(:,:,1)./sumBg;
bg(:,:,2) = bg(:,:,2)./sumBg;
bg(:,:,3) = bg(:,:,3)./sumBg;

image1(:,:,2) = image1(:,:,2) - bg(:,:,2) > -0.07;
image1(:,:,1) = image1(:,:,1) - bg(:,:,1) < -0.16;
image1(:,:,3) = image1(:,:,3) - bg(:,:,3) > -0.02;
shadow = image1(:,:,3) - bg(:,:,3) < -0.27;
image1(:,:,3) = image1(:,:,3) + shadow;

image1(:,:,1) = bwmorph(image1(:,:,1),'clean',2);
image1(:,:,2) = bwmorph(image1(:,:,2),'clean',2);
image1(:,:,3) = bwmorph(image1(:,:,3),'clean',2);

figure(2)
imagesc(image1(:,:,1));
colormap(gray)

for i = 1:3
       [channel,num] = bwlabel(image1(:,:,i),4);
       num;
       stats = regionprops(channel, 'Area','PixelIdxList');
       for m = 1:length(stats)
            list(m) = stats(m).Area;
       end

       maxArea = max(list);
       if i == 1
          redArea = maxArea; 
       elseif i == 2
          greenArea = maxArea; 
       elseif i == 3
           blueArea = maxArea;
       end
end

figure(3)
imagesc(redArea)
colormap(gray)

%blue = image(:,:,2);

%blue = bwmorph(blue,'clean',2);

%imshow(red);
