function [tri1D,tri2D,tri2D_x,tri2D_y] = triangular_Function(image_to_be_filtered)

[sx, sy] = size(image_to_be_filtered);

x =  (-sx/2:sx/2-1)/(sx/2);
tri1D = triangularPulse(x);
tri1D = tri1D(:)/max(tri1D);% Normalized


% 2D Rectangular
tri2D = tri1D * tri1D'; % filtering both x and y axis fft
tri2D_y = tri1D * ones(1,sx); % filtering along y axis fft
tri2D_x = tri2D_y'; % filtering along y axis fft

end

