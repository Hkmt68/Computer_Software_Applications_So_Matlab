% Create input dialog to get resistances and voltage
prompt = {'Enter resistance R1:', 'Enter resistance R2:', 'Enter resistance R3:', 'Enter resistance R4:', 'Enter resistance R5:', 'Enter supply voltage V:'};
dlgtitle = 'Input for Circuit Calculation';
dims = [1 35];
definput = {'20','20','20','20','20','10'}; % default values
inputs = inputdlg(prompt, dlgtitle, dims, definput);

% Convert input to numeric values
R1 = str2double(inputs{1});
R2 = str2double(inputs{2});
R3 = str2double(inputs{3});
R4 = str2double(inputs{4});
R5 = str2double(inputs{5});
V = str2double(inputs{6});

% Calculate total resistance, current, voltages across each resistor, and power dissipated
R_total = R1 + R2 + R3 + R4 + R5;
I = V / R_total;
V1 = I * R1;
V2 = I * R2;
V3 = I * R3;
V4 = I * R4;
V5 = I * R5;
P1 = V1 * I;
P2 = V2 * I;
P3 = V3 * I;
P4 = V4 * I;
P5 = V5 * I;

% Create a figure and uitable
f = figure('Position', [100 100 420 250]); % Adjusted size
t = uitable(f, 'Data', [R1 V1 P1; R2 V2 P2; R3 V3 P3; R4 V4 P4; R5 V5 P5], ...
            'ColumnName', {'Resistance', 'Voltage', 'Power'}, ...
            'RowName', {'R1', 'R2', 'R3', 'R4', 'R5'}, ...
            'Position', [20 20 380 200], ... % Adjusted size
            'BackgroundColor', [0.7 0.9 0.9; 1 1 1]); % Alternating turquoise and white

% Adjust column widths automatically
t.ColumnWidth = {'auto', 'auto', 'auto'};

% Center the figure window on the screen
movegui(f, 'center');
