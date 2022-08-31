clear;
%% Test Loop
n = 0; % number of data pull
GloveData_full = zeros(16, 1); % the 16th data represents the timestamp

%% Call the Mex file and obtain Glove Data
figure(1);
while n < 10000
    disp(n)
    iniData(1:15, 1) = Source_mxArray_3();
    iniData(16, 1) = now;
    GloveData_full = cat(2, GloveData_full, iniData);
    n = n + 1;

end
%% Data Visualization
x = 0 : n;
% GloveData_full = GloveData_full(:, 2:n);
plot(x, GloveData_full(1, :), x, GloveData_full(2, :), x, GloveData_full(3, :))

%% Analysis
% measure and plot the difference between each data pull
t_diff = zeros(n, 1);
for i = 2 : (n - 1)
    t_diff(i, 1) = GloveData_full(16, i + 1) - GloveData_full(16, i);
end
figure(2);
plot(t_diff(1 : n, 1))








    