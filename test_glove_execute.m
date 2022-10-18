clear;
%% Test Loop
n = 0; % number of data pull
GloveData = zeros(16, 1); % the 16th data represents the timestamp

%% Call the Mex file and obtain Glove Data
figure('Name', 'Joint Angle Data');
while n < 10000
    disp(n)
    iniData(1:15, 1) = Source_mxArray_3();
    iniData(16, 1) = now;
    GloveData = cat(2, GloveData, iniData);
    n = n + 1;

end

%% Data storage
writematrix(GloveData, 'Joint_Angle_Data.csv');

%% Data Visualization
x = 0 : n;
% GloveData_full = GloveData_full(:, 2:n);
plot(x, GloveData(1, :), x, GloveData(2, :), x, GloveData(3, :))

%% Analysis
% test_analysis;








    