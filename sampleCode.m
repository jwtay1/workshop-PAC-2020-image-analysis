%This example shows how to segment (identify) individual cells and their
%nuclei.

clearvars %Clear variables in the workspace

%Read image of cell bodies
I = imread('cells.tif');

%Segment the cells using imbinarize
mask = imbinarize(I);
mask = imfill(mask, 'holes');

mask = bwareaopen(mask, 100);
imshowpair(I, mask);  %Display the mask on the image

%Measure length of the cells
celldata = regionprops(mask, I, 'MajorAxisLength', 'MeanIntensity');

%Number of cells
numCells = numel(celldata)

%Average cell length
avgCellLen = mean(cat(1, celldata.MajorAxisLength)) .* 0.4596

%Plot a histogram
histogram(cat(1, celldata.MajorAxisLength), 30)

%Plot the mean intensities
figure;
plot(cat(1, celldata.MeanIntensity))


%Additional: Combine with image of nuclei for color
figure;
Inucl = imread('nuclei.tif');
Irgb = cat(3, I, Inucl, zeros(size(I)));
imshow(Irgb)