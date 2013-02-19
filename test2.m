image1 = double(imread('images/00000049.jpg','jpg'));
bg = double(imread('background.jpg','jpg'));
image1 = mask_clothes(image1);

figure(5)
imshow(uint8(image1));

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

figure(1)
imagesc(image1);
colormap(gray);


sumBg = bg(:,:,1)+bg(:,:,2)+bg(:,:,3);

bg(:,:,1) = bg(:,:,1)./sumBg;
bg(:,:,2) = bg(:,:,2)./sumBg;
bg(:,:,3) = bg(:,:,3)./sumBg;

image1(:,:,2) = image1(:,:,2) - bg(:,:,2) < -0.07;
image1(:,:,1) = image1(:,:,1) - bg(:,:,1) < -0.10;
image1(:,:,3) = image1(:,:,3) - bg(:,:,3) < -0.03;
image1(:,:,3) = image1(:,:,3) - bg(:,:,3) > 0.74;

image1(:,:,1) = bwmorph(image1(:,:,1),'erode',2);
image1(:,:,1) = bwmorph(image1(:,:,1),'dilate',2);
image1(:,:,2) = bwmorph(image1(:,:,2),'erode',2);
image1(:,:,2) = bwmorph(image1(:,:,2),'dilate',2);
image1(:,:,3) = bwmorph(image1(:,:,3),'erode',2);
image1(:,:,3) = bwmorph(image1(:,:,3),'dilate',2);

figure(2)
imagesc(image1(:,:,2));
colormap(gray)

for i = 1:3
       [channel,num] = bwlabel(image1(:,:,i),4);
       num;
       stats = regionprops(channel, 'Area','PixelIdxList');
       length(stats)

       for m = 1:length(stats)
            list(m) = stats(m).Area;
       end

       maxArea = max(list);
       
       
       
       for reg = 1:length(stats)
            if stats(reg).Area < maxArea
                channel(stats(reg).PixelIdxList) = 0;
            end
       end

       if i == 1
          image1(:,:,1) = channel; 
       elseif i == 2
          image1(:,:,2) = channel;
       elseif i == 3
          image1(:,:,3) = channel;
       end
end


figure(3)
imagesc(image1(:,:,2))
colormap(gray)


%blue = image(:,:,2);

%blue = bwmorph(blue,'clean',2);

%imshow(red);
