
% Путь к файлу
directory = 'C:\Users\pavel\OneDrive\Рабочий стол\цос\putty\перевод в вольты';

%имена файлов
fileNames = {
    'putty250.log',
    'putty250_delay.log',
    'putty500.log',
    'putty500_delay.log',
    'putty1000.log',
    'putty1000_delay.log',
    'putty2000.log',
    'putty2000_delay.log',
    'putty10k.log',
    'putty10k_delay.log',
    'putty20k.log',
    'putty20k_delay.log'
};

%массив ячеек с полными путями к файлам
filePaths = cellfun(@(fileName) fullfile(directory, fileName), fileNames, 'UniformOutput', false);

% Выбор нужного файла
filePath=filePaths{12}

fs=744
title_ampl='АЧХ 20kHz с delay'
title_deg='ФЧХ 20kHz с delay'

% Считать данные и перевести в массив данных
data = readtable(filePath, 'FileType', 'text');
dataArray = table2array(data);
dataDouble = double(dataArray);


% Построение графика
figure;
hold on;
plot_fft(dataDouble, fs, 'ачх', title_ampl, title_deg);

 % Функция расчета АЧХ и ФЧХ с помощью фурье
 function plot_fft(signal, fs, type, title_ampl, title_deg)
    length_signal = length(signal);
    % Быстрое преобразование фурье
    converted = fft(signal);
    % Абсолютное значение каждого элемента (чтобы не зависеть от длины сигнала)
    normalization = abs(converted/length_signal);
    % сохраняем только половину спектра (из-за симметрии)
    amplitude = normalization(1:length_signal/2+1);
    % Удваивание значений спектра, так как убрали половину
    amplitude(2:end-1) = 2*amplitude(2:end-1);
    %ось x
    f_freq = fs*(0:(length_signal/2))/length_signal;
    % Максимальная амплитуда
    max_a = max(amplitude);
    % Выбор графика
    if strcmp(type, 'ачх')
        %отрисовка графика
        plot(f_freq, amplitude);
        title(title_ampl);
        % Подпись названий осей
        xlabel('Частота');
        ylabel('Амплитуда');
        
    elseif strcmp(type, 'фчх')
        % Вычисление фаз. сперкта и перевод из рад в градусы
        phase = angle(converted(1:length_signal/2+1)) * 180/pi;
        % фильтрация сигнала
        phase(amplitude< 0.05*max_a) = 0;
        plot(f_freq, phase);
        title(title_deg);
        % Подпись названий осей
        xlabel('Частота');
        ylabel('Градусы');
    end
end
