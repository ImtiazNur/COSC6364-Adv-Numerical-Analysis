function [GL,output_image_low] = normal_Low_Pass_Filter(orginalImage,FFT2D)

% row : no of rows (height of the image)
% col : no of columns (width of the image)
[row, col] = size(orginalImage);


% Cut-off Frequencies
DL = 30; %  cutt-off low pass

% Designing filter
%rows
u = 0:(row-1);
idx = find(u>row/2);
u(idx) = u(idx)-row;

%columns 
v = 0:(col-1);
idy = find(v>col/2);
v(idy) = v(idy)-col;

% Building matrix using u and v.
[V, U] = meshgrid(v, u);

% Calculating Euclidean Distance
D = sqrt(U.^2+V.^2);

% Comparing with the cut-off frequency and determining the filtering mask for low 
L = double(D <= DL); % low 

% Multiplication between the Fourier Transformed image and the mask
GL = L.*FFT2D;

% Getting the filtered image by iFFT
output_image_low = real(ifft2(double(GL)));

end