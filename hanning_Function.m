function [hann1D,hann2D,hann2D_x,hann2D_y] = hanning_Function(image_to_be_filtered)
[sx, sy] = size(image_to_be_filtered);

hann1D = hann(sx);

% hann1D = hann1D(:)/max(hann1D);% Normalized

% 2D Hanning
hann2D = hann1D * hann1D'; % filtering both x and y axis fft
hann2D_y = hann1D * ones(1,sx); % filtering along y axis fft
hann2D_x = hann2D_y'; % filtering along y axis fft

end