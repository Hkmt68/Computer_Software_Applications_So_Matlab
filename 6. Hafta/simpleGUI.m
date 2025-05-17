function simpleGUI
    % GUI bileşenlerinin oluşturulması
    f = figure('Visible', 'off', 'Position', [360, 500, 450, 285]);

    % Başlık
    movegui(f, 'center')
    f.Name = 'Basit MATLAB GUI';

    % Metin etiketi
    htext = uicontrol('Style', 'text', 'String', 'Merhaba, bu basit bir MATLAB GUI örneğidir.', 'Position', [20, 240, 400, 40]);

    % Buton
    hbutton = uicontrol('Style', 'pushbutton', 'String', 'Tıkla', 'Position', [175, 100, 100, 50], ...
        'Callback', @button_callback);

    % GUI'nin görünür yapılması
    f.Visible = 'on';

    % Butona tıklandığında çalışacak fonksiyon
    function button_callback(source, event)
        % Metni güncelle
        htext.String = 'Butona tıklandı!';
    end

end
