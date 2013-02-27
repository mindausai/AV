bg = double(imread('background.jpg'));
average = double(imread('average.jpg'));

files = dir('images/0*.jpg');

vals = get_training_data();
valshsv = rgb2hsv(rgb2nrgb(vals));

count = 1;

matrix = [];

for ii = 1:size(files,1)
    
    column = ii;
    
    im = double(imread(files(ii).name));
    out = detect1(im,bg,average);
    
    tmpChann = zeros(480,640);
    
    for ball = 1:3
        out2 = out;
        sd = std(valshsv(:,ball));
        m = median(valshsv(:,ball));

        lower = m-sd*2;
        upper = m+sd*2;

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
                x = stats(reg).PixelList(:,1);
                y = stats(reg).PixelList(:,2);
                
                %centreX1 = mean(x);
                %centreY1 = mean(y);
                %centreX2 = mean([max(x),min(x)]);
                %centreY2 = mean([max(y),min(y)]);
                %centreX = mean([centreX1,centreX2]);
                %centreY = mean([centreY1,centreY2]);
                centreX = median(x);
                centreY = median(y);
                
                column = [column centreY centreX];
            end
        end
        tmpChann = tmpChann + channel;
    end
    figure(1)
    imshow(tmpChann)
    ii
    matrix = [matrix, column'];
end

save('matrix.mat','matrix');