function asdf = afloader(dirPath)

%{
    Function: afloader2(dirPath)

    Purpose: Reads all airfoil .csv files from a directory and loads them 
    into a cell matrix. Then extracts airfoil geometries from the cell 
    matrix and outputs them into a double matrix.

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - afmat (double matrix containing all airfoil geometries)

    Dependencies:

    Notes:
    - afmat has 2 columns per airfoil [chord, lower and upper surfaces]
    - use afmatinterp to extract upper and lower surfaces from afmat

    TO DO:
    - Eventually combine with afloader2.m (build in operation modes)
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
    
    %% Read output file line-by-line, assigns tline to cell matrix tlines
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

%% Process data in tlines
% cut header off cell matrix
b = tlines(2:end, :);

% create NaN (double) matrix to be filled by airfoil geometry values
afmat = NaN(length(b(:,1)), length(b(1, :))*2);

%% Scan through cell matrix b and convert values to doubles to fill afmat
index = 1; % index to allow for 2-column-wide loading of matrix
for j=1:1:length(b(1, :))
    for k=1:1:length(b(:, 1))
        if not(isempty(b{k, j}))
            afmat(k, index:index+1) = str2double(regexp(string(b(k, j)),...
                '\-?\d*\.\d*|\-?\d\d?\d?\d?','match'));
        end
    end
    % increment index
    index = index + 2;
end

%% Return
asdf = afmat;