bg = double(imread('background.jpg'));
average = double(imread('average.jpg'));


files = dir('images/0*.jpg');

vals = get_training_data();
valshsv = rgb2hsv(rgb2nrgb(vals));

figure(1);
count = 1;

matrix = [];

for ii = 1:size(files,1)
    
    column = ii;
    
    im = double(imread(files(ii).name));
    out = detect1(im,bg,average);
    
    for ball = 1:3
        out2 = out;
        lower = min(valshsv(:,ball));
        upper = max(valshsv(:,ball));

        out2(out2 < lower| out2 > upper) = 0;
        out2(out2 >= lower & out2 <= upper) = 1.0;

        [channel,num] = bwlabel(out2,4);
        stats = regionprops(channel, 'Area','PixelIdxList','PixelList');

        maxArea = -1;

        for m = 1:length(stats)
            area = stats(m).Area;
            if maxArea < area;
                maxArea = area;
            end
        end

        for reg = 1:length(stats)
            if stats(reg).Area < maxArea
                channel(stats(reg).PixelIdxList) = 0;
            else
                areaMean = mean(stats(reg).PixelIdxList);
                channel(stats(reg).PixelIdxList(1));
                x = mean(stats(reg).PixelList(:,1));
                y = mean(stats(reg).PixelList(:,2));
                column = [column y x];
    %            figure(11)
    %            imshow(uint8(im))
    %            hold on
    %            plot(x,y,'ro')
    %            drawnow;
    %            pause(1)
            end
        end
    end
    ii
    matrix = [matrix, column'];
end

save('matrix.mat','matrix');