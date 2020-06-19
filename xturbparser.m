function asdf = xturbparser(tlines, nlines)

%{
    Function: xturbparser(tlines, nlines)

    Purpose: Scans through XTurb output files (tlines) and identifies
    sections of the output files. 

    Parameters: 
    - tlines (xturb output file read into a cell array) 
    - nlines (number of lines in xturb output file)

    Returns:
    - struct s containing:
    - logical column vectors specifying data locations
        - s.output1logical = output1Log;
        - s.output123logical = output123Log;
        - s.predictionlogical = predictLog;
    - 0 and 1 column vectors specifying data locations
        - s.output1binary = output1Bin;
        - s.output123binary = output123Bin;
        - s.predictionbinary = predictBin;

    Notes:
    - ONLY WORKS WITH XTurb_Output1.dat RIGHT NOW

    TO DO:
    - Wrap up code
    - CLEAN UP FOR CONSISTENCY
    - Increase compatibility for any XTurb_Output[X].dat
        - Modify regex or use contains()
%}

%% Scan through output file and identify lines containing specific data
% find the tlines entries that contain output1 data
output1Log = ~cellfun(@isempty,...
    regexp(tlines,'  0.0000  ','match','once')); % logical
output1Bin = double(output1Log);

% find how many radial stations -- NOT USED
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

%% Load parsed xturb data file into structure
s.output1logical = output1Log;
s.output123logical = output123Log;
s.predictionlogical = predictLog;

s.output1binary = output1Bin;
s.output123binary = output123Bin;
s.predictionbinary = predictBin;

%% Debug

%% Return
asdf = s;