% function asdf = afmatsep(dirPath)

%{
    Function: afmatsep(dirPath)

    Purpose: From a file path to a directory, reads all .csv files from the 
    directory and processes them into a matrix of doubles. The airfoil data
    in the matrix of doubles is then separated into upper/lower surfaces
    and loaded into a combined output matrix.

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - afms (double matrix containing all airfoil geometries separated into
    upper and lower surfaces)

    Dependencies:
    - afloader.m
        - dirloader.m

    Notes:

    TO DO:
%}

%% Initial variables
% separate input dirPath into double matrix
clear; clc;
dirPath = "Airfoils/Negative";
afm = afloader(dirPath);

% define number of rows in separated airfoil matrix
if rem(length(afm(:, 1)), 2) == 1
    rows = length(afm(:, 1))/2 + 0.5;
else
    rows = length(afm(:, 1))/2;
end

% create empty separated airfoil matrix
afms = NaN(rows, length(afm(1, :)*2));

%% Separate airfoils in afm into upper/lower surfaces and load into afms
index = 1; % index to allow for 4-column-wide loading of matrix
jndex = 1; % second index because foilSep needs 2-column-wide input

for j=1:1:length(afm(1,:))/2 % (# of columns in afm)/2 = # of airfoils
    % truncate NaNs from chord and upper/lower surface data for foilSep.m
    x = afm(:, jndex);
    x(~any(~isnan(x), 2),:)=[];
    y = afm(:, jndex+1);
    y(~any(~isnan(y), 2),:)=[];
    
    % separate airfoil into upper/lower surfaces, assign to z
    z = foilSep([x, y]);
    
    % load matrix with separated airfoil values
    afms(1:length(z(:,1)), index:index+3) = z;
    
    % revert NaNs converted to zeros when loading airfoil into matrix
    if length(z(:,1)) < rows
        afms(length(z(:,1))+1:end, index:index+3) =...
            NaN(rows - length(z(:,1)), 4);
    end
    
    % increment indices
    index = index + 4;
    jndex = jndex + 2;
end

%% Return
% asdf = afms;