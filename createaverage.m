function a = createaverage()
    files = dir('images/0*.jpg');
    a=double(imread(strcat('images/',files(1).name)));
    for ii = 2:size(files,1)
        a = a+double(imread(strcat('images/',files(ii).name)));
    end
    a=a/size(files,1);