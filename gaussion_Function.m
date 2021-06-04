function [gauss1D,gauss2D,gauss2D_x,gauss2D_y] = gaussion_Function(image_to_be_filtered)
[sx, sy] = size(image_to_be_filtered);
x =  (-sx/2:sx/2-1)/(sx/2) * 9;
gauss1D = normpdf(x,0,1);

gauss1D = gauss1D(:)/max(gauss1D);% Normalized


% 2D Gaussion
gauss2D = gauss1D * gauss1D'; % filtering both x and y axis fft
gauss2D_y = gauss1D * ones(1,sx); % filtering along y axis fft
gauss2D_x = gauss2D_y'; % filtering along y axis fft

end