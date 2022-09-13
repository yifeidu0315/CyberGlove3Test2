clear;
%% Test Loop
n = 0; % number of data pull
GloveData_full_r = zeros(16, 1); % the 16th data represents the timestamp

%% Call the Mex file and obtain Glove Data
figure('Name', 'Joint Angle Data in radius');
while n < 10000
    disp(n)
    iniData(1:15, 1) = Source_mxArray_4();
    iniData(16, 1) = now;
    GloveData_full_r = cat(2, GloveData_full_r, iniData);
    n = n + 1;

end

%% Data storage
writematrix(GloveData_full_r, 'Joint_Angle_Data_radius.csv');

%% Data Visualization
x = 0 : n;
% GloveData_full = GloveData_full(:, 2:n);
plot(x, GloveData_full_r(1, :), x, GloveData_full_r(2, :), x, GloveData_full_r(3, :))

%% Analysis
% test_analysis;








    