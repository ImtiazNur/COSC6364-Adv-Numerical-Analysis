function [hamm1D,hamm2D,hamm2D_x,hamm2D_y] = hamming_Function(image_to_be_filtered)
[sx, sy] = size(image_to_be_filtered);
hamm1D = hamming(sx);

hamm1D = hamm1D(:)/max(hamm1D);% Normalized

% 2D Hamming
hamm2D = hamm1D * hamm1D'; % filtering both x and y axis fft
hamm2D_y = hamm1D * ones(1,sx); % filtering along y axis fft
hamm2D_x = hamm2D_y'; % filtering along y axis fft

end