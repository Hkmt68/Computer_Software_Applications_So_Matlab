% Collecting input data through a compact input dialog setup
prompt = {'Enter resistance R1:', 'Enter resistance R2:', 'Enter resistance R3:', 'Enter resistance R4:', 'Enter resistance R5:', 'Enter supply voltage V:'};
dims = [1 35];
definput = {'20','20','20','20','20','10'};
inputs = inputdlg(prompt, 'Input for Circuit Calculation', dims, definput);

% Assigning inputs and converting to double
R1 = str2double(inputs{1});
R2 = str2double(inputs{2});
R3 = str2double(inputs{3});
R4 = str2double(inputs{4});
R5 = str2double(inputs{5});
V = str2double(inputs{6});

% Calculations
R = [R1, R2, R3, R4, R5];
totalR = sum(R);
I = V / totalR;
Voltages = I .* R;
Powers = Voltages .* I;

% Preparing data for the table
data = [R', Voltages', Powers'];

% Creating and configuring the figure and table
f = figure('Position', [100 100 420 250]);
t = uitable('Parent', f, 'Data', data, ...
            'ColumnName', {'Resistance', 'Voltage', 'Power'}, ...
            'RowName', {'R1', 'R2', 'R3', 'R4', 'R5'}, ...
            'Position', [20 20 380 200], ...
            'BackgroundColor', [0.7 0.9 0.9; 1 1 1]);

% Auto-adjust column widths and center the figure window
t.ColumnWidth = {'auto', 'auto', 'auto'};
movegui(f, 'center');
