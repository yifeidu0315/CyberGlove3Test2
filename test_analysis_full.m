clear;

%% abduction joint analysis
idle_full = readmatrix("abduction data\Full_Joint_Angle_Data_radian_idle.csv"); % when the hand is in idle position
abd1_full = readmatrix("abduction data\Full_Joint_Angle_Data_radian_abd1.csv"); % when thumb and index finger spread apart
abd2_full = readmatrix("abduction data\Full_Joint_Angle_Data_radian_abd2.csv"); % when index finger and middle finger spread apart
abd3_full = readmatrix("abduction data\Full_Joint_Angle_Data_radian_abd3.csv"); % when index finger and ring finger spread apart
abd4_full = readmatrix("abduction data\Full_Joint_Angle_Data_radian_abd4.csv"); % when ring finger and pinky finger spread apart

% cut the initial all zero data
idle_full(:, 1) = [];
abd1_full(:, 1) = [];
abd2_full(:, 1) = [];
abd3_full(:, 1) = [];
abd4_full(:, 1) = [];

% data processing, finding mean from 100 sample
idle_mean = zeros(5, 1);
for index = 1 : 5
    idle_mean(index, 1) = mean(idle_full(index * 4, :));
end

abd1_mean = zeros(5, 1);
for index = 1 : 5
    abd1_mean(index, 1) = mean(abd1_full(index * 4, :));
end

abd2_mean = zeros(5, 1);
for index = 1 : 5
    abd2_mean(index, 1) = mean(abd2_full(index * 4, :));
end

abd3_mean = zeros(5, 1);
for index = 1 : 5
    abd3_mean(index, 1) = mean(abd3_full(index * 4, :));
end

abd4_mean = zeros(5, 1);
for index = 1 : 5
    abd4_mean(index, 1) = mean(abd4_full(index * 4, :));
end

% add data together into a 5*5 matrix
Abduction_full = cat(2, idle_mean, abd1_mean);
Abduction_full = cat(2, Abduction_full, abd2_mean);
Abduction_full = cat(2, Abduction_full, abd3_mean);
Abduction_full = cat(2, Abduction_full, abd4_mean);

figure('Name', "Abduction Analysis");
plot(Abduction_full)
title('Abduction Angle Change')
xlabel('Different Pose')
ylabel('Angle (Radian)')
legend('thumb-index', 'not implemented', 'index-middle', 'middle-ring', 'ring-pinky')
savefig('figures and plots\Average Refresh Rate (for 10 sample chunk).fig');