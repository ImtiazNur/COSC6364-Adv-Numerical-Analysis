function [phase, magnitude] = phaseAndMagnitude(fftImage)
    
shiftedFFT2D = fftshift(fftImage); % Center FFT2
phase = angle(shiftedFFT2D);

magnitude = abs(shiftedFFT2D); % Get the magnitude
magnitude = log(magnitude+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
magnitude = mat2gray(magnitude); % Use mat2gray to scale the image between 0 and 1
end