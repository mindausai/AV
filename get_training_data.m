% Get training value for the 3 balls
function vals = get_training_data
    load gt1

    files = dir('images/0*.jpg');

    vals = ones(99,3,3);
    for ii = 1:size(files,1)
        current = imread(strcat('images/',files(ii).name));   
        vals(ii,:,:) = get_colour_values(current,gt1(:,ii));        
    end
end