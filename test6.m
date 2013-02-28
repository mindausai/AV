load matrix;
load gt1;

files = dir('images/0*.jpg');

figure(1);
for ii = 1:size(files,1)
    
    % plot found centre and ground truth in each image
    Image = imread(files(ii).name);
    imshow(Image);
    hold on;
    plot(matrix(3,ii),matrix(2,ii),'ko');
    plot(matrix(5,ii),matrix(4,ii),'ko');
    plot(matrix(7,ii),matrix(6,ii),'ko');
    plot(gt1(3,ii),gt1(2,ii),'k+');
    plot(gt1(5,ii),gt1(4,ii),'k+');
    plot(gt1(7,ii),gt1(6,ii),'k+');
    drawnow;
    ii
    pause(1)
end

bg = imread('background.jpg');

% red ball trajectory
figure(2); 
imshow(bg);
hold on;
plot(matrix(3,:),matrix(2,:),'-r','LineWidth',2);
drawnow;

% green ball trajectory
figure(3); 
imshow(bg);
hold on;
plot(matrix(5,:),matrix(4,:),'-g','LineWidth',2); 
drawnow;

% yellow ball trajectory
figure(4); 
imshow(bg);
hold on;
plot(matrix(7,:),matrix(6,:),'-y','LineWidth',2);
drawnow;