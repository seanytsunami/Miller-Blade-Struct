function asdf = matrixformatter(lines, dlines, rstations)

%{
    Function: matrixformatter(lines, dlines, rstations)

    Purpose: Formats output123, vwind, or prediction matrices to fit
    dimensions with the bulk data matrix.

    Parameters:
    - lines (extracted data matrix returned by matrixloader.m, AKA actual 
    data)
    - dlines (bulk data matrix for respective data set, used for 
    formatting)
    - rstations (number of radial stations, used for formatting)

    Returns:
    - flines (formatted matrix based upon data contained in lines, and
    dimensions from dlines)

    Dependencies:

    Notes:
    - Remainder in loop rounds truncates counter to fill matrix based upon
    rstations

    TO DO:
%}

%% Initial variables
% create empty formatted array based on the dimensions of dlines and lines
flines = ones(length(dlines(:, 1)), length(lines(1, :)));

%% Load data from lines into formatted flines matrix
for j=1:1:length(dlines(:, 1))
    if rem(j, rstations) == 0
        flines(j,:) = lines(j/rstations, :);
    else
        flines(j,:) = lines((fix(j/rstations) + 1), :);
    end
end

%% Returns
asdf = flines;