image = double(imread('images/00000015.jpg','jpg'));
bg = double(imread('background.jpg','jpg'));

sum = image(:,:,1).^2+image(:,:,2).^2+image(:,:,3).^2;

imR = image(:,:,1);

image(:,:,1) = image(:,:,1)./sqrt(sum); 
image(:,:,2) = image(:,:,2)./sqrt(sum);
%image(:,:,3) = zeros(480,640);
image(:,:,3) = image(:,:,3)./sqrt(sum); 
%image = image - bg;
imshow(image);

sumBg = bg(:,:,1).^2+bg(:,:,2).^2+bg(:,:,3).^2;

bg(:,:,1) = bg(:,:,1)./sqrt(sumBg);
bg(:,:,2) = bg(:,:,2)./sqrt(sumBg);
bg(:,:,3) = bg(:,:,3)./sqrt(sumBg);

%imshow(bg);

image = image - bg;
%imshow(image);

%bg = getbackground4('images',1,480,640,3);
%imshow(bg);