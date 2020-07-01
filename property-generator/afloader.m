function asdf = afloader(dirPath)

%{
    Function: afloader2(dirPath)

    Purpose: Reads all airfoil files from a directory and loads them into 
    a cell matrix. Then extracts airfoil geometries from the cell matrix 
    and outputs them into a double matrix.

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - afmat (double matrix containing all airfoil geometries)

    Dependencies:

    Notes:
    - afloader2 uses a different method to extract airfoil data from a
    directory
    - afloader2 increases compatibility to support .dat and .txt files
    - currently works better than afloader.m for varied file types

    TO DO:
%}

%% Prepare directory path
dirPath = strip(dirPath, 'left', '/');

%% Load info from all files in directory into single cell matrix
csvfiles = dir(strcat(dirPath, "/*.csv"));
datfiles = dir(strcat(dirPath, "/*.dat"));
txtfiles = dir(strcat(dirPath, "/*.txt"));
cfiles = [struct2cell(csvfiles), struct2cell(datfiles),...
    struct2cell(txtfiles)];

% extract file paths from cfiles
fpfiles = strcat(string(cfiles(2, :)), "/", string(cfiles(1, :)));
fpfiles = erase(fpfiles, strcat(pwd, "/"));

%% Determine number of .csv, .dat, and .txt files
ncsv = length(csvfiles(:,1));
ndat = length(datfiles(:,1));
ntxt = length(txtfiles(:,1));

%% Find size of longest airfoil file for pre-allocation
for j=1:1:length(fpfiles)
    if j == 1
        max = length(table2array(readtable(fpfiles(j))));
    elseif length(table2array(readtable(fpfiles(j)))) > max
        max = length(table2array(readtable(fpfiles(j))));
    end
end

%% Create empty matrix based upon length of longest files and # files
afmat = NaN(max, length(fpfiles)*2);

%% Load afmat with airfoil values
index = 1; % index allows for 2-column-wide loading
for j=1:1:length(fpfiles)
    if any(j==1:1:ncsv) % .csv files first
        c = getafdata(fpfiles(j));
        afmat(1:length(c(:,1)), index:index+1) = c;
        
    elseif any(j==ncsv+1:1:ncsv+ndat) % .dat next
        d = getafdata(fpfiles(j));
        afmat(1:length(d(:, 1)), index:index+1) = d;
        
    elseif any(j==ncsv+ndat+1:1:ncsv+ndat+ntxt) % .txt last
        e = getafdata(fpfiles(j));
        afmat(1:length(e(:, 1)), index:index+1) = e;
    end
    
    % increment counter
    index = index + 2;
end

%% Return
asdf = afmat;