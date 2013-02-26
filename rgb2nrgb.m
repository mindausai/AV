function m = rgb2nrgb(i)
    m = double(i);
    sum = m(:,:,1)+m(:,:,2)+m(:,:,3);
    
    m(:,:,1) = m(:,:,1)./sum; 
    m(:,:,2) = m(:,:,2)./sum;
    m(:,:,3) = m(:,:,3)./sum; 