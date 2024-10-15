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

hz=1000
phi=3
fs_teor=44100
fs_exp=774
length_file=7740

xlim_1=0
xlim_2=0.09

title_name='Сравнение при 10kHz с delay'


%массив ячеек с полными путями к файлам
filePaths = cellfun(@(fileName) fullfile(directory, fileName), fileNames, 'UniformOutput', false);

% Выбор нужного файла
filePath=filePaths{10}

% Считать данные и перевести в массив данных
data = readtable(filePath, 'FileType', 'text');
dataArray = table2array(data);
dataDouble = double(dataArray);

%Расчет графиков
t=0:1/fs_teor:(length_file-1)/fs_teor
y=sin(2*pi*hz*t+phi)+1.62


t1 = 0:1/fs_exp:(length_file-1)/fs_exp
% Построение графика
figure;
hold on;
plot(t, y, 'k', 'DisplayName', 'теоретическое значение');
plot(t1, dataDouble, 'r','DisplayName', 'практическое значение');

xlim([xlim_1, xlim_2]);

% Подпись названия графика
title(title_name);

% Подпись названий осей
xlabel('Время (с)');
ylabel('Значение');

% Добавление легенды
legend show;