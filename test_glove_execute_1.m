clear;
%% Test Loop
n=0;
% size of the returned matrix
size_m = 5;
size_n = 3;
% delta time since the first update
deltaT = 0;
baseT = 0;

GloveData_full = zeros(size_m, size_n, 1);
GloveData_last = zeros(size_m, size_n, 1);
while n < 30
    %% Call the Mex file and obtain Glove Data 1 time
    iniData_linear = Source_mxArray_3();
    %% disp("Data Linearized");
    
    %% Format the Data into a 5x3 double precision array
    % for now we are not sure what is the cause of the incorrect array
    % formatting in matlab workspace. This is only a temporary fix as the 
    % time efficiency of the program is acceptable
    
    index = 0;
    for index_m = 1 : size_m
        for index_n = 1 : size_n
            index = index + 1;
            % disp(index);
            GloveData_last(index_m, index_n, 1) = iniData_linear(index);
            % disp(iniData_linear(index));

        end
    end
    disp("Data from last pull stored in array 'GloveData_last'");

    % merge the matrix together to combine data
    GloveData_full = cat(3, GloveData_full, GloveData_last);
    n=n+1;

end