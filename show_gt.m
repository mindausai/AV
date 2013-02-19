load gt1

files = dir('images/0*.jpg');
bg= imread('background.jpg');

figure(1);
current = imread(strcat('images/',files(1).name));
for ii = 1:size(files,1)
    prev = current;
    current = imread(strcat('images/',files(ii).name));
    %imshow(Image);
    hold on;
    %plot(gt1(3,ii),gt1(2,ii),'r.');
    %plot(gt1(5,ii),gt1(4,ii),'g.');
    %plot(gt1(7,ii),gt1(6,ii),'y.');
    %dohist(Image, 1);
    imshow(current-bg);
    drawnow;
end
