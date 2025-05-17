clc
close all
clear all %#ok<CLALL>

s = serial('COM7','BaudRate',9600); %#ok<SERIAL>
fopen(s);
fprintf(s,'*IDN?');
i = 1;
while true
    x(i) = str2double(fscanf(s)); %#ok<SAGROW>
    i = i + 1;
    plot(x)
    pause(0.1)
end