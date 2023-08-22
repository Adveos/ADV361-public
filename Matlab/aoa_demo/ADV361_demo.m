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
% ADV361 AoA processing demo
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% ADV361 serial port
s_port_name = 'COM8'; 

% Initialize serial port
s_port = serialport(s_port_name, 1e6);
configureTerminator(s_port, "CR/LF");
pause(0.1)

% Reset ADV361 SoC
reset_serial(s_port);

% Configure serial port callback function
configureCallback(s_port, "terminator", @read_serial)

%% IMPORTANT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Issue the following command to disable callback
% configureCallback(s_port, "off")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BK3633 chip reset
function reset_serial(s_port)
disp('Rebooting...')
writeline(s_port,"AT+REBOOT")
s_port.flush
pause(1)
disp('Sync...')
pause(1)
writeline(s_port,"AT+SYNC on")
disp('Scan...')
pause(1)
writeline(s_port,"AT+SCAN on")
pause(1)
s_port.flush
end

% Read serial data callback
function read_serial(s_port, ~)

persistent t0 h_gfx

% Initialize on first run
if isempty(t0)
    
    % Initialize timer
    t0 = tic;

    % Initialize plot
    h_gfx = init_plots();
end

% Read serial port data
read_port = (char(readline(s_port)));

% Check if this is a valid measurement
if ~isempty(read_port) && (numel(read_port) > 4) && strcmp(read_port(1:5), '{"aoa')

    try
        % UART data are in json format
        all_info = jsondecode(read_port);

        % AoA estimate from ADV361
        phi_est = all_info.aoa.est(1);
        theta_est = all_info.aoa.est(2);

        % Update plots 5 times per second
        if (toc(t0) > 0.2)
            update_plots(h_gfx, phi_est, theta_est);
            t0 = tic;
        end

        % Check if too much data is buffered and flush the serial port
        if (s_port.NumBytesAvailable > 10e3)
            s_port.flush
            fprintf('!')
        end
        drawnow

    catch err
        % Something went, wrong, flush serial port and continue
        fprintf('x')
        pause(1)
        s_port.flush
    end
end

end