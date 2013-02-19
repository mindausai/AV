function [ background ] = getbackground4( path, imageGap, HEIGHT, WIDTH, DIM )
%GETBACKGROUND Summary of this function goes here
%   Detailed explanation goes here

   % imageGap = 5;
   
    background = zeros(HEIGHT,WIDTH,DIM);
    images = zeros(HEIGHT*WIDTH,DIM * 99/imageGap);
    k = 1;
    prev = 0;
    curr = 0;
    graph = zeros(100,1);
    while k < 100;
        k = k + 1;
        if k < 10
            fullpath = [path '/0000000' int2str(k) '.jpg'];
        elseif k == 100
            fullpath = [path '/00000' int2str(k) '.jpg'];
        else
            fullpath = [path '/000000' int2str(k) '.jpg'];
        end
        
        prev = curr;
        curr = importdata(fullpath,'jpg');
        if k > 1
            temp = (curr - prev);
            graph(k - 1) = mean(abs(temp(:)));
        end
    end
    graph = graph(2:end);
    graph = graph ./ max(graph);
    plot(graph,'g-');
    graph;
    k = imageGap+1;
    index = 0;
    while k <= 100;
       % if k > 60
       %     imageGap = 5;
       % end
        
        if k < 10
            fullpath = [path '/0000000' int2str(k) '.jpg'];
        elseif k == 100
            fullpath = [path '/00000' int2str(k) '.jpg'];
        else
            fullpath = [path '/000000' int2str(k) '.jpg'];
        end
        
        index = index + 1;
        currentImage = importdata(fullpath,'jpg');
        
        tmp = currentImage(:,:,1);
        images(:, (index - 1) * 3 + 1) = tmp(:);
        tmp = currentImage(:,:,2);
        images(:, (index - 1) * 3 + 2) = tmp(:);
        tmp = currentImage(:,:,3);
        images(:, (index - 1) * 3 + 3) = tmp(:);
        
        k = k + imageGap;
    end
    
        r = median(images(:,1:3:end), 2);
        g = median(images(:,2:3:end), 2);
        b = median(images(:,3:3:end), 2);
        
        background(:,:,1) = reshape(r, HEIGHT, WIDTH); 
        background(:,:,2) = reshape(g, HEIGHT, WIDTH); 
        background(:,:,3) = reshape(b, HEIGHT, WIDTH); 
end

