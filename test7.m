load gt1
load matrix

errorR = [];
errorG = [];
errorY = [];

for i = 1:size(matrix,2)
    % calculate Eucledian distance between found centre and ground truth
    red = sqrt((gt1(3,i)-matrix(3,i))^2 + (gt1(2,i) - matrix(2,i))^2);
    green = sqrt((gt1(5,i)-matrix(5,i))^2 + (gt1(4,i) - matrix(4,i))^2);
    yellow = sqrt((gt1(7,i)-matrix(7,i))^2 + (gt1(6,i) - matrix(6,i))^2);
    
    % error vectors
    errorR = [errorR red];
    errorG = [errorG green];
    errorY = [errorY yellow];
end

% find maximum, minimum and total balls error. Also count the times than
% found centre is larger than 10 pixels from ground truth
figure(1)
hist(errorR);
errorCountR = sum(errorR > 10)
maxErrorR = max(errorR)
minErrorR = min(errorR)
sumErrorR = sum(errorR)

figure(2)
hist(errorG);
errorCountG = sum(errorG > 10)
maxErrorG = max(errorG)
minErrorG = min(errorG)
sumErrorG = sum(errorG)

figure(3)
hist(errorY);
errorCountY = sum(errorY > 10)
maxErrorY = max(errorY)
minErrorY = min(errorY)
sumErrorY = sum(errorY)

% total sumed error for all balls
totalError = sum([sumErrorR,sumErrorG,sumErrorY])