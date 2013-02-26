% Given an image and a set of coordinates, return the corresponding colour
% value at the points in the image
% Assume: points are [i,rr,rc,gr,gc,yr,yc]'
% Output: 1x3x3 [[r,g,b],...] array
function colour_values = get_colour_values(im, points)
    colour_values = ones(1,3,3);
    colour_values(1,1,:) = im(points(2),points(3),:);
    colour_values(1,2,:) = im(points(4),points(5),:);
    colour_values(1,3,:) = im(points(6),points(7),:);    
end