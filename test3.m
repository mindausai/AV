image = double(imread('images/00000020.jpg','jpg'));
bg = double(imread('background.jpg','jpg'));

image(:,:,1) = (abs(image(:,:,1) - bg(:,:,1))>10) ;
image(:,:,2) = (abs(image(:,:,2)-bg(:,:,2))>10) ;
image(:,:,3) = (abs(image(:,:,3)-bg(:,:,3))>10);
imshow(image);