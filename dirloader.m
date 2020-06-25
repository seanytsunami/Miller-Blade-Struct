function asdf = dirloader(dirPath)

%{
    Function: dirloader(dirPath)

    Purpose: Load all .csv files from 

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - tlines (cell matrix containing all airfoil geometries)

    Dependencies:

    Notes:
    - DOES NOT WORK WITH .dat FILES AT THE MOMENT (NOT SURE WHY)

    TO DO:
    - make .dat files work, look into .txt files
%}

%% Load files from directory into cell array
csvfiles = dir(strcat(dirPath, "/*.csv"));
datfiles = dir(strcat(dirPath, "/*.dat")); % .dat files not working
cfiles = [struct2cell(csvfiles), struct2cell(datfiles)];

% create empty cell array to be filled
tlines = cell(0, length(cfiles(1, :)));

%% Loop through all files in directory
for j=1:1:length(cfiles(1, :))
    %% Open file
    fid = fopen(string(cfiles(1,j)));
    
    %% Read output file line-by-line, assigns tline to cell array tlines
    nlines = 0;
    tline = fgetl(fid);
    
    % read through data file
    while ischar(tline)
        % increment counter
        nlines = nlines + 1;
        
        % load current tline into column vector tlines
        tlines{nlines,j} = tline;
        
        % increment tline
        tline = fgetl(fid);
    end
    
    %% Close file
    fclose(fid);
end

%% Return
asdf = tlines;