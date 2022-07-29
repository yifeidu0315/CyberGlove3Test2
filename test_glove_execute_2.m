%% Test Loop
n=0;
size_m = 6;
size_n = 3;
while n<5000
    %% Call the Mex file and obtain Glove Data 1 time
    iniData = Source_mxArray_2();
    iniData_linear = iniData(:);
    %% Format the Data into a 6x3 double precision array
    % for now we are not sure what is the cause of the incorrect array
    % formatting in matlab workspace. This is only a temporary fix as the 
    % time efficiency of the program is a concern.
    GloveData_last = zeros(size_m, size_n);
    GloveData_full = zeros(size_m, size_n, 1);
    for index_m = 1 : size_m
        for index_n = 1 : size_n
            index = index_m * index_n;
            GloveData_last(index_m, index_n) = iniData_linear(index);
        end
    end
    GloveData_full = cat(3, GloveData_full, GloveData_last);
    n=n+1;

end