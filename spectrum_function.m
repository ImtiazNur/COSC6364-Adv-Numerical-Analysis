function [freq,spectrum] = spectrum_function(orginalImage,fft2d)
col = length(orginalImage);

% The function fftshift is needed to put the DC component (frequency = 0) in the center.
shifted_FFT=fftshift(fft2d);
spectrum=abs(shifted_FFT).^2; % Power Spectrum
freq=-col/2:col/2-1; % frequency 
end