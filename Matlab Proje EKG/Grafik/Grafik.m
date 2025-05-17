% Seri port ayarları
serialPort = 'COM10'; % Arduino'nun bağlı olduğu seri portu belirtin
baudRate = 9600;
s = serial(serialPort, 'BaudRate', baudRate);
fopen(s);

% Veri okuma ve grafik oluşturma
data = [];
figure;
h = plot(nan, nan); % Boş bir grafik oluşturma
xlabel('Zaman (ms)');
ylabel('EKG Sinyali');
title('Gerçek Zamanlı EKG Grafiği');

while ishandle(h) % Grafik penceresi açık olduğu sürece döngü devam eder
    if s.BytesAvailable > 0
        % Seri porttan veri oku
        newData = fscanf(s, '%d');
        data = [data; newData];
        
        % Zaman ölçeğini güncelle
        time = (0:length(data)-1) * 2; % 2 ms örnekleme periyodu
        
        % Grafiği güncelle
        set(h, 'XData', time, 'YData', data);
        drawnow;
    end
end

% Seri portu kapatma ve temizleme
fclose(s);
delete(s);
clear s;
