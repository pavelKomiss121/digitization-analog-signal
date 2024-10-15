% Путь к файлу
directory = 'C:\Users\pavel\OneDrive\Рабочий стол\цос\putty';

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

%путь к целевой папке
targetDirectory = 'C:\Users\pavel\OneDrive\Рабочий стол\цос\putty\перевод в вольты';

%Проход по каждому файлу и обработка 
for i = 1:length(filePaths)
    filePath = filePaths{i};
    data = readtable(filePath, 'FileType', 'text');
    dataMatrix = table2array(data);

    processedData = dataMatrix * (5 / 1023);
    
    % запись в файл
    [~, fileName, ~] = fileparts(filePath);
    targetFilePath = fullfile(targetDirectory, [fileName, '.log']);
    writematrix(processedData, targetFilePath, 'FileType', 'text');

end