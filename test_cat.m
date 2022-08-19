n = 1;
data = ones(6, 3, 1);
data_new = zeros(6, 3, 1);
while n < 5
    data_new = cat(3, data_new, data);
    n = n + 1;
end
