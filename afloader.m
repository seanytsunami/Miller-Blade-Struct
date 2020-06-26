function asdf = afloader(dirPath)

%{
    Function: afloader(tlines)

    Purpose: Reads all .csv files from a directory and loads them into a
    cell matrix. Then extracts airfoil geometries from the cell matrix and
    outputs them into a double matrix.

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - afmat (double matrix containing all airfoil geometries from tlines)

    Dependencies:
    - dirloader.m (deals with the .csv files in the directory)

    Notes:
    - afmat has 2 columns per airfoil [chord, lower and upper surfaces]
    - use foilSep.m to extract upper and lower surfaces from afmat
    - afloader.m is is a more workable version of dirloader.m

    TO DO:
%}

%% Initial variables
% define directory path
tlines = dirloader(dirPath);

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