clc;
close all;
clear;

serialPort = 'COM7'; % Kullanılacak port
baudRate = 9600;
s = serialport(serialPort, baudRate);
configureTerminator(s, 'LF'); % Sonlandırıcıyı ayarla

data = [];
figure;
h = plot(nan, nan);
xlabel('Time (s)');
ylabel('Sensor Value');

while ishandle(h)
    if s.NumBytesAvailable > 0
        newData = str2double(readline(s));
        data = [data; newData];
        plot(data);
        drawnow;
    end
    pause(0.1);
end
