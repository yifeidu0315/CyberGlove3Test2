% measure and plot chunk average fps for each 10 samples
avg_size = 10;
avg_fps_10 = zeros(n / avg_size, 1);
avg_fps = n /((GloveData_full(16, n) - GloveData_full(16, 2))* 24 * 60 * 60);
for i = 1 : n / avg_size
    avg_fps_10(i, 1) = avg_size / ((GloveData_full(16, i * avg_size) - GloveData_full(16, (i - 1) * avg_size + 1))* 24 * 60 * 60);
end
fluc_10 = avg_fps_10(:, 1) - avg_fps;
figure(3);
plot((1:1000), avg_fps_10,':', (1:1000), fluc_10)

std_avg_fps_10 = std(avg_fps_10(2 : 1000, 1)); % calculate standard deviation of the average fps

% measure and plot chunk average fps for each 100 samples
avg_size = 100;
avg_fps_100 = zeros(n / avg_size, 1);
avg_fps = n /((GloveData_full(16, n) - GloveData_full(16, 2))* 24 * 60 * 60);
for i = 1 : n / avg_size
    avg_fps_100(i, 1) = avg_size / ((GloveData_full(16, i * avg_size) - GloveData_full(16, (i - 1) * avg_size + 1))* 24 * 60 * 60);
end
fluc_100 = avg_fps_100(:, 1) - avg_fps;
figure(4);
plot((1:100), avg_fps_100,':', (1:100), fluc_100)
std_avg_fps_100 = std(avg_fps_100(2 : 100, 1)); % calculate standard deviation of the average fps