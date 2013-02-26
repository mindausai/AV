bg = double(imread('background.jpg'));
average = double(imread('average.jpg'));
im = double(imread('images/00000002.jpg'));

vals = get_training_data();
valshsv = rgb2hsv(rgb2nrgb(vals));

out = detect1(im,bg,average);
figure(1);
imshow(out);

lower = min(valshsv(:,2));
upper = max(valshsv(:,2));

out(out < lower| out > upper) = 0;
out(out >= lower & out <= upper) = 1.0;

figure(2);
imshow(out);