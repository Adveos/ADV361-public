%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MIT License
%
% Copyright (c) 2023 ADVEOS
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ADV361 demo plot initialization
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function h_gfx = init_plots()

% Create figure
h_gfx{1} = figure("Position",[200 200 500 500]);

% Plot for estimated Phi/Theta
plot(nan(0));
xlim([-75 75])
ylim([-75 75])
grid('on');
title('Estimated Az/El angles')
xlabel('Azimuth angle (deg)')
ylabel('Elevation angle (deg)')

% Set X, Y ticks grid every 5 degrees
xticks(-75:5:75);
yticks(-75:5:75);

% Target color
colmap = colormap('lines');
target_color = colmap(1, :);

% Create 4 lines for target
h_gfx{2}.aoa_target_left     = line([0 0], [0 0], 'Color', target_color, 'LineWidth', 5);
h_gfx{2}.aoa_target_right    = line([0 0], [0 0], 'Color', target_color, 'LineWidth', 5);
h_gfx{2}.aoa_target_up       = line([0 0], [0 0], 'Color', target_color, 'LineWidth', 5);
h_gfx{2}.aoa_target_down     = line([0 0], [0 0], 'Color', target_color, 'LineWidth', 5);

% Az / El text
h_gfx{2}.aoa_az_text = text(0, 0, '', 'FontName', 'Courier new', 'FontSize', 18, 'FontWeight', 'bold', 'Color', target_color);
h_gfx{2}.aoa_el_text = text(0, 0, '', 'FontName', 'Courier new', 'FontSize', 18, 'FontWeight', 'bold', 'Color', target_color);

% Empty area inside target
h_gfx{2}.target_len = 5;

end