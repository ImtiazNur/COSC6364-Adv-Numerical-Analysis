function Out_FFT_2D = FFT_2D_Function(image)

[row, col] = size(image);
% Initializing matrix
wRow = zeros(row, row); 
wCol = zeros(col, col); 

for i = 0 : (row - 1) 

    for x = 0 : (row - 1) 

        wRow(i+1, x+1) = exp(-2 * pi * 1i / row * x * i); 

    end     

end 


for j = 0 : (col - 1) 

    for y = 0 : (col - 1) 

        wCol(y+1, j+1) = exp(-2 * pi * 1i / col * y * j); 

    end     

end 

Out_FFT_2D = wRow * im2double(image) * wCol;
    
end
