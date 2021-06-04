classdef ANA_Project_GUI_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        DesignedbyFettahKiranMohammadImtiazNurLabel  matlab.ui.control.Label
        DDataFrequencyandConvolutionalAnalysisLabel  matlab.ui.control.Label
        FFT2DImplementationsPanel  matlab.ui.container.Panel
        EnergySpectrumButton       matlab.ui.control.Button
        FFT2DButton                matlab.ui.control.Button
        PhaseandMagnitudeButton    matlab.ui.control.Button
        RealandImaginaryButton     matlab.ui.control.Button
        FiltersDropDown            matlab.ui.control.DropDown
        FiltersDropDownLabel       matlab.ui.control.Label
        PhantomSizeDropDown        matlab.ui.control.DropDown
        PhantomSizeDropDownLabel   matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: FFT2DButton
        function FFT2DButtonPushed(app, event)
            
            phantom_size = app.PhantomSizeDropDown.Value;
            figure('Name','FFT 2D Image','NumberTitle','off');
            orginal_Image = phantom(str2num(phantom_size));
            output_FFT2D = FFT_2D_Function(orginal_Image)
            imshow(output_FFT2D);
            title('FFT 2D');
     
        
        end

        % Value changed function: PhantomSizeDropDown
        function PhantomSizeDropDownValueChanged(app, event)
            phantom_size = app.PhantomSizeDropDown.Value;
            figure('Name','Original Image','NumberTitle','off');
            orginal_Image = phantom(str2num(phantom_size));
            imshow(orginal_Image);
            size = phantom_size;
%             title(sprintf('Original Image size %.0d', num2str(size)));
            title('Orginal Image');
            savefig(orginal_Image, sprintf('OrginalImage%d.png',k)'-%d',size);
            
        end

        % Value changed function: FiltersDropDown
        function FiltersDropDownValueChanged(app, event)
           
            filter_name = app.FiltersDropDown.Value;
            phantom_size = app.PhantomSizeDropDown.Value;
            orginal_Image = phantom(str2num(phantom_size));
            output_FFT2D = FFT_2D_Function(orginal_Image);
                    
        

            if strcmpi(filter_name, 'High Pass(Normal)')
                [filtered_fft2D_high, high_pass_out] = normal_High_Pass_Filter(orginal_Image,output_FFT2D);
                figure('Name','High Pass(Normal)','NumberTitle','off');
                subplot(1, 4, 1), imshow(orginal_Image), title('Orginal Image');
                subplot(1, 4, 2), imshow(output_FFT2D),title('FFT2D');
                subplot(1, 4, 3), imshow(filtered_fft2D_high), title('Filtered FFT2D');
                subplot(1, 4, 4), imshow(high_pass_out,[]),title('Filtered Image');
                sgtitle('Normal High Pass Filter (cut-off freq = 11)')

            elseif strcmpi(filter_name, 'Low Pass(Normal)')
                [filtered_fft2D_low,low_pass_out ]= normal_Low_Pass_Filter(orginal_Image,output_FFT2D)
                figure('Name','Low Pass(Normal)','NumberTitle','off');
                subplot(1, 4, 1), imshow(orginal_Image), title('Orginal Image');
                subplot(1, 4, 2), imshow(output_FFT2D),title('FFT2D');
                subplot(1, 4, 3), imshow(filtered_fft2D_low), title('Filtered FFT2D');
                subplot(1, 4, 4), imshow(low_pass_out,[]),title('Filtered Image');
                sgtitle('Normal Low Pass Filter (cut-off freq = 30)');
                
            elseif strcmpi(filter_name, 'Butterworth High')
                [filtered_fft2D_Bt_high ,bt_high_pass_out] = butterWorth_High_Pass_Filter(orginal_Image,output_FFT2D)
                figure('Name','Butterworth High','NumberTitle','off');
                subplot(1, 4, 1), imshow(orginal_Image), title('Orginal Image');
                subplot(1, 4, 2), imshow(output_FFT2D),title('FFT2D');
                subplot(1, 4, 3), imshow(filtered_fft2D_Bt_high), title('Filtered FFT2D');
                subplot(1, 4, 4), imshow(bt_high_pass_out,[]),title('Filtered Image');
                sgtitle('Butterworth High Pass Filter (cut-off freq = 11, order = 2)');
                           
                elseif strcmpi(filter_name, 'Butterworth Low')
                [filtered_fft2D_Bt_low,bt_low_pass_out] = butterWorth_Low_Pass_Filter(orginal_Image,output_FFT2D)
                figure('Name','Butterworth Low','NumberTitle','off');
                subplot(1, 4, 1), imshow(orginal_Image), title('Orginal Image');
                subplot(1, 4, 2), imshow(output_FFT2D),title('FFT2D');
                subplot(1, 4, 3), imshow(filtered_fft2D_Bt_low), title('Filtered FFT2D');
                subplot(1, 4, 4), imshow(bt_low_pass_out,[]),title('Filtered Image');
                sgtitle('Butterworth Low Pass Filter (cut-off freq = 30, order = 2)');         
            
            
            
                elseif strcmpi(filter_name, 'Guassion 2D')
                [gauss1D, gauss2D, gauss2D_x_axis,gauss2D_y_axis]= gaussion_Function(orginal_Image);
                
                filtered_gauss2D= ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* gauss2D); % element wise of matrix = density weighted filtering
                filtered_gauss2D_x_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* gauss2D_x_axis);
                filtered_gauss2D_y_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* gauss2D_y_axis);
             
                figure('Name','Gaussion 2D Image Filter','NumberTitle','off');
                
                
                
                subplot(2,3,1), imshow(gauss2D), title('Gauss 2D');
                subplot(2,3,2), imshow(gauss2D_x_axis), title('Gauss 2D x axis');
                subplot(2,3,3), imshow(gauss2D_y_axis), title('Gauss 2D y axis');
                
                subplot(2,3,4), imshow(filtered_gauss2D), title('Gauss 2D');
                subplot(2,3,5), imshow(filtered_gauss2D_x_axis), title('Gauss 2D x axis');
                subplot(2,3,6), imshow(filtered_gauss2D_y_axis), title('Gauss 2D y axis');
                sgtitle('Gaussion 2D Image Filter');
                
                
            elseif strcmpi(filter_name, 'Triangular 2D')
                [tri1D, tri2D, tri2D_x_axis, tri2D_y_axis] = triangular_Function(orginal_Image)

                
                filtered_tri2D= ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* tri2D); % element wise of matrix = density weighted filtering
                filtered_tri2D_x_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* tri2D_x_axis);
                filtered_tri2D_y_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* tri2D_y_axis);
             
                figure('Name','Triangular 2D Image Filter','NumberTitle','off');
                
                
                subplot(2,3,1), imshow(tri2D), title('Triangular 2D');
                subplot(2,3,2), imshow(tri2D_x_axis), title('Triangular 2D x axis');
                subplot(2,3,3), imshow(tri2D_y_axis), title('Triangular 2D y axis');
                
                
                subplot(2,3,4), imshow(filtered_tri2D), title('Triangular 2D');
                subplot(2,3,5), imshow(filtered_tri2D_x_axis), title('Triangular 2D x axis');
                subplot(2,3,6), imshow(filtered_tri2D_y_axis), title('Triangular 2D y axis');
                
                sgtitle('Triangular 2D Image Filter');
                
       
              elseif strcmpi(filter_name, 'Hamming 2D')
                [hamm1D, hamm2D, hamm2D_x_axis, hamm2D_y_axis] = hamming_Function(orginal_Image)

                
                filtered_hamm2D= ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hamm2D); % element wise of matrix = density weighted filtering
                filtered_hamm2D_x_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hamm2D_x_axis);
                filtered_hamm2D_y_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hamm2D_y_axis);
             
                figure('Name','Hamming 2D Image Filter','NumberTitle','off');
                
                
                subplot(2,3,1), imshow(hamm2D), title('Hamming 2D');
                subplot(2,3,2), imshow(hamm2D_x_axis), title('Hamming 2D x axis');
                subplot(2,3,3), imshow(hamm2D_y_axis), title('Hamming 2D y axis');
                
                
                subplot(2,3,4), imshow(filtered_hamm2D), title('Hamming 2D');
                subplot(2,3,5), imshow(filtered_hamm2D_x_axis), title('Hamming 2D x axis');
                subplot(2,3,6), imshow(filtered_hamm2D_y_axis), title('Hamming 2D y axis');
                
                sgtitle('Hamming 2D Image Filter');
                
                
                
                
              elseif strcmpi(filter_name, 'Hanning 2D')
                [hann1D, hann2D, hann2D_x_axis, hann2D_y_axis] = hanning_Function(orginal_Image)

                
                filtered_hann2D= ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hann2D); % element wise of matrix = density weighted filtering
                filtered_hann2D_x_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hann2D_x_axis);
                filtered_hann2D_y_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* hann2D_y_axis);
             
                figure('Name','Hanning 2D Image Filter','NumberTitle','off');
                
                
                subplot(2,3,1), imshow(hann2D), title('Hanning 2D');
                subplot(2,3,2), imshow(hann2D_x_axis), title('Hanning 2D x axis');
                subplot(2,3,3), imshow(hann2D_y_axis), title('Hanning 2D y axis');
                
                
                subplot(2,3,4), imshow(filtered_hann2D), title('Hanning 2D');
                subplot(2,3,5), imshow(filtered_hann2D_x_axis), title('Hanning 2D x axis');
                subplot(2,3,6), imshow(filtered_hann2D_y_axis), title('Hanning 2D y axis');
                
                sgtitle('Hanning 2D Image Filter');

            
            else
                [rect1D, rect2D, rect2D_x_axis, rect2D_y_axis]= rectangular_Function(orginal_Image);

                
                filtered_rect2D= ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* rect2D); % element wise of matrix = density weighted filtering
                filtered_rect2D_x_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* rect2D_x_axis);
                filtered_rect2D_y_axis = ifft2(fftshift(FFT_2D_Function(orginal_Image)) .* rect2D_y_axis);
             
                figure('Name','Rectangular 2D Image Filter','NumberTitle','off');
                
                
                subplot(2,3,1), imshow(rect2D), title('Rectangular 2D');
                subplot(2,3,2), imshow(rect2D_x_axis), title('Rectangular 2D x axis');
                subplot(2,3,3), imshow(rect2D_y_axis), title('Rectangular 2D y axis');
                
                
                subplot(2,3,4), imshow(filtered_rect2D), title('Rectangular 2D');
                subplot(2,3,5), imshow(filtered_rect2D_x_axis), title('Rectangular 2D x axis');
                subplot(2,3,6), imshow(filtered_rect2D_y_axis), title('Rectangular 2D y axis');
                
                sgtitle('Rectangular 2D Image Filter');
            end
            

            
        end

        % Button pushed function: RealandImaginaryButton
        function RealandImaginaryButtonPushed(app, event)
            phantom_size = app.PhantomSizeDropDown.Value;
            figure('Name','Real and Imaginary','NumberTitle','off');
            orginal_Image = phantom(str2num(phantom_size));
            output_FFT2D = FFT_2D_Function(orginal_Image)
            
            imaginary_part = imag(output_FFT2D);
            real_part = real(output_FFT2D);
            subplot(1,2,1)
            imshow(fftshift(imaginary_part)), title('Imaginary')
            subplot(1,2,2)
            imshow(fftshift(real_part)), title('Real');
            sgtitle('Real and Imaginary part of FFT 2D');
        end

        % Button pushed function: PhaseandMagnitudeButton
        function PhaseandMagnitudeButtonPushed(app, event)
            phantom_size = app.PhantomSizeDropDown.Value;
            figure('Name','Phase and Magnitude ','NumberTitle','off');
            orginal_Image = phantom(str2num(phantom_size));
            output_FFT2D = FFT_2D_Function(orginal_Image)
            
            [phase, magnitude] = phaseAndMagnitude(output_FFT2D);        
            subplot(1,2,1)
            imagesc(phase);  colormap(gray); title('Phase')
            subplot(1,2,2)
            imagesc(magnitude); title('Magnitude - Log Scale')            
            sgtitle('Phase and Magnitude of FFT 2D');
        end

        % Button pushed function: EnergySpectrumButton
        function EnergySpectrumButtonPushed(app, event)
            phantom_size = app.PhantomSizeDropDown.Value;
            figure('Name','Energy Spectrum','NumberTitle','off');
            orginal_Image = phantom(str2num(phantom_size));
            output_FFT2D = FFT_2D_Function(orginal_Image)
            
            [freq,spectrum] = spectrum_function(orginal_Image, output_FFT2D);        
            subplot(1,2,1)
            imagesc(freq,freq,spectrum),colormap gray;colorbar ,title('Linear') % linear
            subplot(1,2,2)
            imagesc(freq,freq,log(spectrum)),colormap gray;colorbar ,title('Logarithmic') % logarithmic

            sgtitle('Energy Spectrum Using FFT2D')
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 595 286];
            app.UIFigure.Name = 'MATLAB App';

            % Create PhantomSizeDropDownLabel
            app.PhantomSizeDropDownLabel = uilabel(app.UIFigure);
            app.PhantomSizeDropDownLabel.HorizontalAlignment = 'right';
            app.PhantomSizeDropDownLabel.FontWeight = 'bold';
            app.PhantomSizeDropDownLabel.Position = [24 190 84 22];
            app.PhantomSizeDropDownLabel.Text = 'Phantom Size';

            % Create PhantomSizeDropDown
            app.PhantomSizeDropDown = uidropdown(app.UIFigure);
            app.PhantomSizeDropDown.Items = {'64', '128', '1024', '4096'};
            app.PhantomSizeDropDown.ValueChangedFcn = createCallbackFcn(app, @PhantomSizeDropDownValueChanged, true);
            app.PhantomSizeDropDown.Position = [147 190 65 22];
            app.PhantomSizeDropDown.Value = '64';

            % Create FiltersDropDownLabel
            app.FiltersDropDownLabel = uilabel(app.UIFigure);
            app.FiltersDropDownLabel.HorizontalAlignment = 'right';
            app.FiltersDropDownLabel.FontWeight = 'bold';
            app.FiltersDropDownLabel.Position = [24 132 41 22];
            app.FiltersDropDownLabel.Text = 'Filters';

            % Create FiltersDropDown
            app.FiltersDropDown = uidropdown(app.UIFigure);
            app.FiltersDropDown.Items = {'Select a filter type', 'High Pass(Normal)', 'Low Pass(Normal)', 'Butterworth High', 'Butterworth Low', 'Guassion 2D', 'Rectangular 2D', 'Triangular 2D', 'Hamming 2D', 'Hanning 2D'};
            app.FiltersDropDown.ValueChangedFcn = createCallbackFcn(app, @FiltersDropDownValueChanged, true);
            app.FiltersDropDown.Position = [80 132 159 22];
            app.FiltersDropDown.Value = 'Select a filter type';

            % Create FFT2DImplementationsPanel
            app.FFT2DImplementationsPanel = uipanel(app.UIFigure);
            app.FFT2DImplementationsPanel.TitlePosition = 'centertop';
            app.FFT2DImplementationsPanel.Title = 'FFT  2D  Implementations';
            app.FFT2DImplementationsPanel.BackgroundColor = [1 1 1];
            app.FFT2DImplementationsPanel.FontWeight = 'bold';
            app.FFT2DImplementationsPanel.Position = [305 20 260 221];

            % Create RealandImaginaryButton
            app.RealandImaginaryButton = uibutton(app.FFT2DImplementationsPanel, 'push');
            app.RealandImaginaryButton.ButtonPushedFcn = createCallbackFcn(app, @RealandImaginaryButtonPushed, true);
            app.RealandImaginaryButton.Position = [71 111 119 22];
            app.RealandImaginaryButton.Text = 'Real and Imaginary';

            % Create PhaseandMagnitudeButton
            app.PhaseandMagnitudeButton = uibutton(app.FFT2DImplementationsPanel, 'push');
            app.PhaseandMagnitudeButton.ButtonPushedFcn = createCallbackFcn(app, @PhaseandMagnitudeButtonPushed, true);
            app.PhaseandMagnitudeButton.Position = [65 63 133 22];
            app.PhaseandMagnitudeButton.Text = 'Phase and Magnitude';

            % Create FFT2DButton
            app.FFT2DButton = uibutton(app.FFT2DImplementationsPanel, 'push');
            app.FFT2DButton.ButtonPushedFcn = createCallbackFcn(app, @FFT2DButtonPushed, true);
            app.FFT2DButton.Position = [81 153 100 24];
            app.FFT2DButton.Text = 'FFT2D';

            % Create EnergySpectrumButton
            app.EnergySpectrumButton = uibutton(app.FFT2DImplementationsPanel, 'push');
            app.EnergySpectrumButton.ButtonPushedFcn = createCallbackFcn(app, @EnergySpectrumButtonPushed, true);
            app.EnergySpectrumButton.Position = [77 16 108 22];
            app.EnergySpectrumButton.Text = 'Energy Spectrum';

            % Create DDataFrequencyandConvolutionalAnalysisLabel
            app.DDataFrequencyandConvolutionalAnalysisLabel = uilabel(app.UIFigure);
            app.DDataFrequencyandConvolutionalAnalysisLabel.HorizontalAlignment = 'center';
            app.DDataFrequencyandConvolutionalAnalysisLabel.FontSize = 15;
            app.DDataFrequencyandConvolutionalAnalysisLabel.FontWeight = 'bold';
            app.DDataFrequencyandConvolutionalAnalysisLabel.Position = [128 254 344 22];
            app.DDataFrequencyandConvolutionalAnalysisLabel.Text = '2D Data Frequency and Convolutional Analysis';

            % Create DesignedbyFettahKiranMohammadImtiazNurLabel
            app.DesignedbyFettahKiranMohammadImtiazNurLabel = uilabel(app.UIFigure);
            app.DesignedbyFettahKiranMohammadImtiazNurLabel.FontSize = 13;
            app.DesignedbyFettahKiranMohammadImtiazNurLabel.Position = [24 13 153 64];
            app.DesignedbyFettahKiranMohammadImtiazNurLabel.Text = {'Designed by '; ''; 'Fettah Kiran'; 'Mohammad Imtiaz Nur'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ANA_Project_GUI_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end