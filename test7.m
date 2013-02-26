load gt1
load matrix

errorR = [];
errorG = [];
errorY = [];

for i = 1:size(matrix,2)
    red = sqrt((gt1(3,i)-matrix(3,i))^2 + (gt1(2,i) - matrix(2,i))^2);
    green = sqrt((gt1(5,i)-matrix(5,i))^2 + (gt1(4,i) - matrix(4,i))^2);
    yellow = sqrt((gt1(7,i)-matrix(7,i))^2 + (gt1(6,i) - matrix(6,i))^2);
    
    errorR = [errorR red];
    errorG = [errorG green];
    errorY = [errorY yellow];
end

hist(errorR)
max(errorG);
errorY;