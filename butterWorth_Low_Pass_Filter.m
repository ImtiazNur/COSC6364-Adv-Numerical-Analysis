function [G_Bt_L,output_image_Bt_L] = butterWorth_Low_Pass_Filter(orginalImage,FFT2D)

% row : no of rows (height of the image)
% col : no of columns (width of the image)
[row, col] = size(orginalImage);

% Our FFT2D function for FFT2 implementations

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


% determining the filtering mask for Butterworth low 
order=2; % order
mask_BW_L = 1./(1 + (DL./D).^(2*order)); % Butterworth low 

% Multiplication between the Fourier Transformed image and the mask
G_Bt_L = mask_BW_L.*FFT2D; % Butterworth Low Pass Filter

% Getting the filtered image by iFFT2
output_image_Bt_L = real(ifft2(double(G_Bt_L)));  % Output of Butterworth Low Pass Filter

end