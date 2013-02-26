load gt1

files = dir('images/0*.jpg');
bg = double(imread('background.jpg'));
av = double(imread('average.jpg'));

figure(1);
vals = ones(99,3,3);
for ii = 1:size(files,1)
    current = imread(strcat('images/',files(ii).name));   
    vals(ii,:,:) = get_colour_values(current,gt1(:,ii));
    %plot(gt1(3,ii),gt1(2,ii),'r.');
    %plot(gt1(5,ii),gt1(4,ii),'g.');
    %plot(gt1(7,ii),gt1(6,ii),'y.');
    %dohist(Image, 1);
    imshow(current);
    %drawnow;
end
