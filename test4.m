im = double(imread('images/00000095.jpg'));
bg = double(imread('background.jpg'));
av = double(imread('average.jpg'));

%Gaussian blur
G = fspecial('gaussian',[5 5],2);

im = imfilter(im,G,'same');
av = imfilter(av,G,'same');

im = mask_clothes(im);
imnrgb = rgb2nrgb(im);
imhsv = rgb2hsv(im);
imhsvsatmask = imhsv(:,:,2) > 50/255;
bgnrgb = rgb2nrgb(bg);
bghsv = rgb2hsv(bg);
avnrgb = rgb2nrgb(av);
avnrgbdif = imnrgb - avnrgb; avnrgbdif(isnan(avnrgbdif)) = 0;
avnrgbdifhsv = rgb2hsv(avnrgbdif);
avnrgbdifhsvmask = avnrgbdifhsv(:,:,3) > 7/255;
bgnrgbdif = imnrgb- bgnrgb;
bgmask = imhsv(:,:,1) > 0.15;
imnrgbmasked = imnrgb(:,:,1).*bgmask;

%{
figure(1);
imshow(imnrgb);
figure(2);
imshow(imhsv);
figure(3);
imshow(bgmask);
figure(4);
imshow(imnrgbmasked);
imshow(imhsv(:,:,1).*avnrgbdifhsvmask);
imshow(imhsvclothes(:,:,1).*avnrgbdifhsvmask);
imshow(im - av);
%}
figure(5);
imshow((imhsv(:,:,1).*imhsvsatmask.*avnrgbdifhsvmask));