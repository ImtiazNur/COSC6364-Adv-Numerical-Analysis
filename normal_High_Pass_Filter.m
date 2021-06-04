function [GH,output_image_high] = normal_High_Pass_Filter(orginalImage,FFT2D)

% row : no of rows (height of the image)
% col : no of columns (width of the image)
[row, col] = size(orginalImage);


% Cut-off Frequencies
DH = 11; % cutt-off  high pass

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

% Comparing with the cut-off frequency and determining the filtering mask for high and low 
H = double(D > DH); % high


% Multiplication between the Fourier Transformed image and the mask
GH = H.*FFT2D;


% Getting the filtered image by iFFT2
output_image_high = real(ifft2(double(GH)));

end