function [G_Bt_H,output_image_Bt_H] = butterWorth_High_Pass_Filter(orginalImage,FFT2D)

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

% determining the filtering mask for Butterworth high and low 
order=2; % order
mask_BW_H = 1./(1 + (DH./D).^(2*order)); % Butterworth high

% Multiplication between the Fourier Transformed image and the mask
G_Bt_H = mask_BW_H.*FFT2D; % Butterworth High Pass Filter

% Getting the filtered image by iFFT2
output_image_Bt_H = real(ifft2(double(G_Bt_H)));  %Output of Butterworth High Pass Filter

end