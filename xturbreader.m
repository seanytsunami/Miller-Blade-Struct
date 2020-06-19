function xturbreader(filePath)

%{
    Function: xturbreader(filePath)

    Purpose: Extract data from "XTurb_Output1.dat" and write to .csv

    Parameters: 
    - filePath (string specifying file path of output file)

    Returns: None, void function. Writes .csv to function working directory

    Notes:
    - COMPATIBLE WITH XTurb-PSU-g77 ONLY [other versions untested]

    TO DO:
    - Wrap up code
    - CLEAN UP FOR CONSISTENCY
    - Increase compatibility for any XTurb_Output[X].dat
        - Create respective functions
%}

clear; clc;

%% Initial variables
% sample file paths
f1 = "XTurb/2to25/XTurb_Output1.dat";
f2 = "XTurb/cd0jx31/XTurb_Output1.dat";

% create variable headers
output123 = ["TSR", 'PITCH [deg]', 'CT', 'CP', 'CPV', 'CB', 'CBV'];
output1 = ["r/R", 'Chord/R', 'Twist [deg]', 'AOA [deg]', 'PHI [deg]', 'CL',...
    'CD', 'CL/CD', 'VSEC', 'VSECX', 'VSECY', 'VSECZ', 'Re'];

%% Open file
fid = fopen(f2);
% fid = fopen(filePath);

%% Read line-by-line, define variables
nlines = 0;
tline = fgetl(fid);
tlines = cell(0,1);

% read through data file
while ischar(tline)
    % increment counter
    nlines = nlines + 1;
    
    % load current tline into column vector
    tlines{end+1,1} = tline;
    
    % increment tline
    tline = fgetl(fid);
end

% convert tline cells to strings
strlines = string(tlines);

t
% find the tlines entries that contain output1 data
output1Log = ~cellfun(@isempty,...
    regexp(tlines,'  0.0000  ','match','once')); % logical
output1Bin = double(output1Log);

% find how many radial stations
rstations = 0;
for j=1:1:nlines
    if  (output1Log(j) & not(output1Log(j + 1)))
        rstations = rstations + 1;
        break
    elseif output1Log(j)
        rstations = rstations + 1;
    end
end

% find the tline entries that contain TSR
output123Log = ~cellfun(@isempty,...
    regexp(tlines,'Number   TSR','match','once'));
output123Bin = zeros(max(size(output123Log)), 1);
for j=1:1:nlines
    if output123Log(j)
        output123Bin(j+1) = 1;
    end
end
output123Log = logical(output123Bin);

% find the tline entries that contain prediction parameters
predictLog = ~cellfun(@isempty,...
    regexp(tlines,'  PREDICTION','match','once'));
predictBin = zeros(max(size(output123Log)), 1);
for j=1:1:nlines
    if predictLog(j)
        predictBin(j+2) = 1;
    end
end
predictLog = logical(predictBin);

%% Test function xturbparser.m
testStructOut = xturbparser(tlines, nlines);

%% Load arrays with data from identified rows in tlines
% load floats into output1 matrix (extract floats from string array)
counter = 0;
dlines = zeros(sum(output1Log), 13);
for j=1:1:nlines
    if output1Log(j)
        counter = counter + 1;
        dlines(counter, :) = str2double(regexp(strlines(j),'\-?\d*\.\d*','match')');
    end
end

% load floats into output123 matrix (extract floats from string array)
counter = 0;
O123lines = zeros(sum(output123Log), 7);
for j=1:1:nlines
    if output123Log(j)
        counter = counter + 1;
        O123lines(counter, :) = str2double(regexp(strlines(j),'\d*\.\d*','match')');
    end
end

% create formatted output123 matrix (in variable O123lines2)
O123lines2 = ones(length(dlines(:, 1)), length(O123lines(1, :)));
for j=1:1:length(dlines(:, 1))
    if rem(j, rstations) == 0
        O123lines2(j,:) = O123lines(j/rstations, :);
    else
        O123lines2(j,:) = O123lines((fix(j/rstations) + 1), :);
    end
end

%% Finalize outputs
% create final matrix and final table
headers = [output123, output1];
numbers = [O123lines2, dlines];
endmatrix = [headers; numbers];
endtable = cell2table(num2cell(numbers),'VariableNames', headers);

%% Write endtable to .csv
writetable(endtable, 'testTable.csv');

%% Close file
fclose(fid);

%% Debug
% type XTurb/2to25/XTurb_Output.dat

end