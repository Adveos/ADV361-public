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
% ADV361 demo plot update
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function update_plots(h_gfx, phi, theta)

% Target center coordinates
x_center = phi;
y_center = theta;

% Update target lines
h_gfx{2}.aoa_target_left.XData = [-75, x_center - h_gfx{2}.target_len];
h_gfx{2}.aoa_target_left.YData = [y_center y_center];
h_gfx{2}.aoa_target_right.XData = [x_center + h_gfx{2}.target_len, 75];
h_gfx{2}.aoa_target_right.YData = [y_center y_center];
h_gfx{2}.aoa_target_up.XData = [x_center, x_center];
h_gfx{2}.aoa_target_up.YData = [-75, y_center - h_gfx{2}.target_len];
h_gfx{2}.aoa_target_down.XData = [x_center, x_center];
h_gfx{2}.aoa_target_down.YData = [y_center + h_gfx{2}.target_len, 75];

% Set Az/El text
h_gfx{2}.aoa_az_text.String = sprintf('Az: %.0f^0', phi);
h_gfx{2}.aoa_az_text.Position = [x_center + 10, 30, 0];
h_gfx{2}.aoa_el_text.String = sprintf('El: %.0f^0', theta);
h_gfx{2}.aoa_el_text.Position = [20, y_center + 10, 0];

end