clear;
%% Test Loop
n = 0; % number of data pull
GloveData_full_r = zeros(25, 1); % the 16th data represents the timestamp

%% Call the Mex file and obtain Glove Data
figure('Name', 'Joint Angle Data in radian');
while n < 100
    disp(n)
    iniData(1:24, 1) = Source_mxArray_5();
    iniData(25, 1) = now;
    GloveData_full_r = cat(2, GloveData_full_r, iniData);
    n = n + 1;

end

%% Data storage
writematrix(GloveData_full_r(:, 2 : n + 1), 'Full_Joint_Angle_Data_radian_abd4.csv');

%% Data Visualization
x = 0 : n;
% GloveData_full = GloveData_full(:, 2:n);
plot(x, GloveData_full_r(1, :), x, GloveData_full_r(2, :), x, GloveData_full_r(3, :))

%% Analysis
% test_analysis;








    