load gt1;

bg = double(imread('background.jpg'));
average = double(imread('average.jpg'));

files = dir('images/0*.jpg');

vals = get_training_data();
valshsv = rgb2hsv(rgb2nrgb(vals));

count = 1;

matrix = [];

%loop which goes through all images
for ii = 1:size(files,1)
    
    % initialisation of vector, which would be added to final output matrix
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

        % label all the connected objects in image
        [channel,num] = bwlabel(out2,4);
        % get the properties of each labeled area
        stats = regionprops(channel, 'Area','PixelIdxList','PixelList');

        maxArea = -1;
        
        % find the biggest area in image
        for m = 1:length(stats)
            area = stats(m).Area;
            if maxArea < area;
                maxArea = area;
            end
        end

        for reg = 1:length(stats)
            
            % cut all smaller areas than maximum
            if stats(reg).Area < maxArea
                channel(stats(reg).PixelIdxList) = 0;
            else
                
                % find centre of maximum area
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
        if ball == 1
            redChan = channel;
        end
        if ball == 2
            greenChan = channel;
        end
        if ball == 3
            yellowChan = channel;
        end
    end
    figure(1)
    imshow(tmpChann)
    ii
    
    % output matrix
    matrix = [matrix, column'];
    
    figure(2)
    imshow(redChan)
    
    figure(3)
    imshow(greenChan)
    
    figure(4)
    hold on
    imshow(yellowChan)
    plot(gt1(7,ii),gt1(6,ii),'r+');
    plot(centreX,centreY,'.r');
    drawnow
    yellow = sqrt((gt1(7,ii)-centreX)^2 + (gt1(6,ii) - centreY)^2)
end

save('matrix.mat','matrix');