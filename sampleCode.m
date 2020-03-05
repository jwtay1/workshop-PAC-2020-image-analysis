%This example shows how to segment (identify) individual cells and their
%nuclei.

%Read image of cell bodies
I = imread('cells.tif');

%Segment the cells using imbinarize
mask = imbinarize(I);
mask = imfill(mask, 'holes');

mask = bwareaopen(mask, 100);
imshowpair(I, mask, 'montage');  %Display the mask of the image

%Measure length of the cells
celldata = regionprops(mask, 'MajorAxisLength');

%Number of cells
numCells = numel(celldata)

%Average cell length
avgCellLen = mean([celldata.MajorAxisLength]) .* 0.4596

%Plot a histogram
histogram([celldata.MajorAxisLength], 30)

%Combine with image of nuclei for color
Inucl = imread('nuclei.tif');

Irgb = cat(3, I, Inucl, zeros(size(I)));
imshow(Irgb)