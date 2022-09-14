%% import workspace data (Optional)
% load('Sep 7 workspace');

%% data visualization in degree
figure('Name', 'Sample in degrees')
x = 0 : n;
plot(x, GloveData_full_r(1, :) * (180 / pi), x, GloveData_full_r(2, :) * (180 / pi), x, GloveData_full_r(3, :) * (180 / pi))
title('Sample in degrees')
legend('metacarpal','proximal', 'distal')
xlabel('Sample No.')
ylabel('Angle in (degree)')
savefig('figures and plots\Sample in degrees.fig');

%% measure and plot the difference between each data pull
t_diff = zeros(n, 1);
for i = 2 : (n - 1)
    t_diff(i, 1) = (GloveData_full_r(16, i + 1) - GloveData_full_r(16, i))* 24 * 60 * 60 * 1000;
end
figure('Name', 'Inividual Time Interval (between each data pull)');
plot(t_diff(1 : n, 1))
title('Inividual Time Interval (between each data pull)')
xlabel('Sample No.')
ylabel('Time(ms)')
savefig('figures and plots\Inividual Time Interval.fig');
avg_t_diff = mean(t_diff); % average time interval in ms.

%% measure and plot chunk average refresh rate for each 10 samples
avg_size = 10;
avg_fps_10 = zeros(n / avg_size, 1);
avg_fps = n /((GloveData_full_r(16, n) - GloveData_full_r(16, 2))* 24 * 60 * 60);
for i = 1 : n / avg_size
    avg_fps_10(i, 1) = avg_size / ((GloveData_full_r(16, i * avg_size) - GloveData_full_r(16, (i - 1) * avg_size + 1))* 24 * 60 * 60);
end
fluc_10 = avg_fps_10(:, 1) - avg_fps;
figure('Name', 'Average Refresh Rate (for 10 sample chunk)');
plot((1:1000), avg_fps_10,':', (1:1000), fluc_10)
title('Average Refresh Rate (for 10 sample chunk)')
xlabel('Chunk No.')
ylabel('Refresh per second (/s)')
legend('original', 'offset')
savefig('figures and plots\Average Refresh Rate (for 10 sample chunk).fig');

std_avg_fps_10 = std(avg_fps_10(2 : 1000, 1)); % calculate standard deviation of the average refresh rate

%% measure and plot chunk average refresh rate for each 100 samples
avg_size = 100;
avg_fps_100 = zeros(n / avg_size, 1);
avg_fps = n /((GloveData_full_r(16, n) - GloveData_full_r(16, 2))* 24 * 60 * 60);
for i = 1 : n / avg_size
    avg_fps_100(i, 1) = avg_size / ((GloveData_full_r(16, i * avg_size) - GloveData_full_r(16, (i - 1) * avg_size + 1))* 24 * 60 * 60);
end
fluc_100 = avg_fps_100(:, 1) - avg_fps;
figure('Name', 'Average Refresh Rate (for 100 sample chunk)');
plot((1:100), avg_fps_100,':', (1:100), fluc_100)
title('Average Refresh Rate (for 100 sample chunk)')
xlabel('Chunk No.')
ylabel('Refresh per second (/s)')
legend('original', 'offset')
savefig('figures and plots\Average Refresh Rate (for 100 sample chunk).fig');

std_avg_fps_100 = std(avg_fps_100(2 : 100, 1)); % calculate standard deviation of the average refresh rate

%% measure and plot a windowed refresh rate with numeric convolution


%% measure the 99% and 95% refresh rate
% sorted_avg_fps_10 = sort(avg_fps_100);
avg_fps_10_99 = quantile(avg_fps_10, [.01 .99]); % switch to quantile
avg_fps_10_95 = quantile(avg_fps_10, [.05 .95]);

%% measure and plot the distribution of repeated frames
repetition_r = zeros(1);
rep_count = 1;
i = 1;
j = 1;
while i < (length(GloveData_full_r) - j)
    while i + j < (length(GloveData_full_r)) & (GloveData_full_r((1 : 15), i) == GloveData_full_r((1 : 15), i + j))
        rep_count = rep_count + 1;
        j = j + 1;
    end
    repetition_r = [repetition_r, rep_count]; % need to figure out how to determine the size of the array for speed.
    rep_count = 1;
    i = i + j + 1;
    j = 1;
end

figure('Name', 'Distribution of repeated frames');
histogram(repetition_r);
title('Repetition distribution')
xlabel('Number of repetition')
ylabel('Number of sample')
savefig('figures and plots\Repetition distribution.fig');


%% measure and plot the distribution of angle increment sizes
increments_r = zeros(15, length(GloveData_full_r) - 1);

i = 1;
while i < length(increments_r)

    increments_r(:, i) = GloveData_full_r((1:15), i + 1) - GloveData_full_r((1:15), i); 
    i = i + 1;
end
% note that increments_r is a 15 x 10000 array and the histogram only shows
% one row of it, need to fix that for more accurate visualization

% remove the samples with increment of zero, as this is due to the
% significantly higher pulling rate
increments_r_nonzero = increments_r;
increments_r_nonzero(increments_r_nonzero == 0) = [];

avg_increment_abs = mean(abs(increments_r_nonzero)) * (180 / pi); % average increment in degrees

figure('Name', 'Distribution of angle increment sizes (in radian)');
histogram(increments_r(1, :)); % display increment sizes
title('Distribution of angle increment sizes (in radian)')
xlabel('Increment size (radian)')
ylabel('Number of sample')
savefig('figures and plots\Increment sizes (radian).fig');

figure('Name', 'Distribution of non-zero angle increment sizes (in radian)');
histogram(increments_r_nonzero(1, :)); % display increment sizes
title('Distribution of non-zero angle increment sizes (in radian)')
xlabel('Increment size (radian)')
ylabel('Number of sample')
savefig('figures and plots\Non-zero increment sizes (radian).fig');

figure('Name', 'Distribution of angle increment sizes (in degree)');
histogram(increments_r(1, :) * (180 / pi)); % display increment sizes
title('Distribution of angle increment sizes (in degree)')
xlabel('Increment size (degree)')
ylabel('Number of sample')
savefig('figures and plots\Increment sizes (degree).fig');

figure('Name', 'Distribution of non-zero angle increment sizes (in degree)');
histogram(increments_r_nonzero(1, :) * (180 / pi)); % display increment sizes
title('Distribution of non-zero angle increment sizes (in degree)')
xlabel('Increment size (degree)')
ylabel('Number of sample')
savefig('figures and plots\Non-zero increment sizes (degree).fig');

%% save all workspace variables
save('Sep 13 workspace');
