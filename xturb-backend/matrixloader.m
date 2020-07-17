function asdf = matrixloader(tlines, datalog, nvars)

%{
    Function: matrixloader(tlines, datalog, nvars)

    Purpose: Loads variables from identified sections of xturb output files
    into matrices.

    Parameters:
    - tlines (xturb output file read into a cell array)
    - dataLog (logical array for respective data set)
    - nvars (number of expected variables/columns)

    Returns:
    - dlines (matrix containing data corresponding to datalog)

    Dependencies:

    Notes:

    TO DO:
    - ADD SUPPORT FOR ASTERISKS IN XTURB OUTPUT
        - integer support screws things up
%}

%% Initial variables
% convert tlines to strlines if necessary
strlines = string(tlines);

% initialize counter
counter = 0;

% create empty matrix for data
dlines = zeros(sum(datalog), nvars);

% regex parameter for detecting doubles and asterisks
dbast = ('(\-?\d*\.\d*)|(\*+)');

%% Scan through strlines and load doubles into dedicated matrix 
for j=1:1:length(strlines(:,1))
    if datalog(j)
        counter = counter + 1;
        dlines(counter, :) =...
            str2double(regexp(strlines(j), dbast, 'match')');
    end
end

%% Return
asdf = dlines; % size [length(strlines(:,1)), nvars]