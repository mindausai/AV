function m = mask_clothes(image)
    m = double(image);
    thresh = 50;
    mask = im2bw(image, thresh/255);

    m(:,:,1) = m(:,:,1).*mask;
    m(:,:,2) = m(:,:,2).*mask;
    m(:,:,3) = m(:,:,3).*mask;
    m = uint8(m);