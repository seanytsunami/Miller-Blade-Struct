function asdf = getafdata(filePath)

%{
    Function: getafdata(filePath)

    Purpose: Format .csv, .dat, and .txt files by removing header(s) and
    extracting data.

    Parameters:
    - filePath (file path to target airfoil file)

    Returns:
    - af (airfoil data)

    Dependencies:

    Notes:

    TO DO:
%}

%% Prepare file path
filePath = strip(filePath, 'left', '/');

%% Read file to array
af = table2array(readtable(filePath));

%% Process file
h = isnan(af); % find NaN's in airfoil
r = find(h); % find NaN indices
af(r, :) = []; % remove NaN's

%% Return
asdf = af;