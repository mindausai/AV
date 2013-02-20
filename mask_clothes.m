function m = mask_clothes(image)
    m = image;
    thresh = 30;
    mask = im2bw(uint8(image), thresh/255);

    m(:,:,1) = m(:,:,1).*mask;
    m(:,:,2) = m(:,:,2).*mask;
    m(:,:,3) = m(:,:,3).*mask;