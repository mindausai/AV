load gt1;

bg = double(imread('background.jpg'));
average = double(imread('average.jpg'));

files = dir('images/0*.jpg');

% trains clasifier for ball colors
vals = get_training_data();
valshsv = rgb2hsv(rgb2nrgb(vals));

count = 1;

matrix = [];

%loop which goes through all images
for ii = 1:size(files,1)
    
    % initialisation of vector, which would be added to final output matrix
    % Final form: [i,rr,rc,gr,gc,yr,yc]
    column = ii;
    
    im = double(imread(files(ii).name));
    
    % applies all the mask to the image
    out = detect1(im,bg,average);
    
    for ball = 1:3
        out2 = out;
        sd = std(valshsv(:,ball));
        m = median(valshsv(:,ball));

        lower = m-sd*2;
        upper = m+sd*2;
        
        % tresholding the image by the ball color using values gotten from clasifier
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
                centreX = median(x);
                centreY = median(y);
                
                column = [column centreY centreX];
            end
        end
    end
    
    % output matrix
    % Final form: [[i,rr,rc,gr,gc,yr,yc]'...] one column for eahc image
    matrix = [matrix, column'];
    
end

save('matrix.mat','matrix');