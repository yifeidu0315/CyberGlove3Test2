clear;
%% Test Loop
n=0;
GloveData_full = zeros(15, 1);

%% Call the Mex file and obtain Glove Data
figure(1);
while n < 10000
    disp(n)
    iniData = Source_mxArray_3();

    GloveData_full = cat(2, GloveData_full, iniData);
    n = n + 1;

end
x = 0 : n;
plot(x, GloveData_full(1, :), x, GloveData_full(2, :), x, GloveData_full(3, :))





    