image1 = double(imread('images/00000040.jpg','jpg'));
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
image1(:,:,1) = image1(:,:,1) - bg(:,:,1) > -0.16;
image1(:,:,3) = image1(:,:,3) - bg(:,:,3) > -0.02;
shadow = image1(:,:,3) - bg(:,:,3) < -0.27;
image1(:,:,3) = image1(:,:,3) + shadow;

image(:,:,1) = bwmorph(image(:,:,1),'erode',2);

imagesc(image1(:,:,1))
colormap(gray)

%blue = image(:,:,2);

%blue = bwmorph(blue,'clean',2);

%imshow(red);
