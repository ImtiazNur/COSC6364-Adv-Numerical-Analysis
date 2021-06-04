function [rect1D,rect2D,rect2D_x,rect2D_y] = rectangular_Function(image_to_be_filtered)

[sx, sy] = size(image_to_be_filtered);

x =  (-sx/2:sx/2-1)/(sx/2);
rect1D = rectangularPulse(x);
rect1D = rect1D(:)/max(rect1D);% Normalized


% 2D Rectangular
rect2D = rect1D * rect1D'; % filtering both x and y axis fft
rect2D_y = rect1D * ones(1,sx); % filtering along y axis fft
rect2D_x = rect2D_y'; % filtering along y axis fft

end

