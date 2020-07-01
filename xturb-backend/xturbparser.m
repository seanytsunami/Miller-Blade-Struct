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
    - fileType (number from 0 to 3)
    - logical column vectors specifying data locations
        - s.output1logical = outputLog;
        - s.output123logical = output123Log;
        - s.vwindlogical = vwindLog;
        - s.predictionlogical = predictLog;
        - s.output0logical = output0Log;
    - rstations (number of radial stations)

    Dependencies:

    Notes:
    - ONLY WORKS WITH PREDICTION MODE RIGHT NOW

    TO DO:
    - investigate double detection vs int vs asterisk
        - not sure if it will screw up and detect things it shouldn't
    - Differentiate radial stations from prediction mode test cases for
    output0 (see xturbreader)
    - Optimize algorithm in the long term
%}

%% Identify type of xturb data file
fileType = NaN;
for j=1:1:nlines
    % search for output file specific strings
    if ~cellfun(@isempty, regexp(tlines(j), 'Blade Radius', 'match'))
        fileType = 0;
        break
    elseif ~cellfun(@isempty, regexp(tlines(j), 'VSECX', 'match'))
        fileType = 1;
        break
    elseif ~cellfun(@isempty, regexp(tlines(j), 'CTangen', 'match'))
        fileType = 2;
        break
    elseif ~cellfun(@isempty, regexp(tlines(j), 'CBendingV', 'match'))
        fileType = 3;
        break
    elseif (j == nlines)
        disp('Incompatible xturb output file. Exiting...');
        asdf = fileType;
        return
    end
end

%% Identify tlines entries containing bulk data for output[1-3]
% find tlines entries that contain doubles
outputDoubleLog = ~cellfun(@isempty,...
    regexp(tlines,'\-?\d*\.\d*','match')); % logical
outputDoubleBin = double(outputDoubleLog);

% find row before bulk data for XTurb_Output[1-3].dat
outputHyphenLog = ~cellfun(@isempty,...
    regexp(tlines,'-',...
    'match')); % logical
outputHyphenBin = double(outputHyphenLog);

% create logical and binary array for identified bulk data
record = 0;
for j=1:1:nlines
    % necessary check for array index
    if j > 1
        % tells when to start recording values
        if outputHyphenLog(j - 1) && outputDoubleLog(j)
            record = 1;
        elseif not(outputDoubleLog(j))
            record = 0;
        end
        
        % records logic into Bin array
        if record
            outputBin(j) = 1;
        end
    end
end
outputLog = logical(outputBin);

%% Identify entries containing additional variables for output[1-3]
% find the tline entries containing TSR, PITCH, CT, etc.
output123Log = ~cellfun(@isempty,...
    regexp(tlines,'Number   TSR','match','once'));
output123Bin = zeros(max(size(output123Log)), 1);
for j=1:1:nlines
    if output123Log(j)
        output123Bin(j+1) = 1;
    end
end
output123Log = logical(output123Bin);

% find entries with VWIND, RPM, PITCH
vwindLog = ~cellfun(@isempty,...
    regexp(tlines,'  VWIND ','match','once'));
vwindBin = zeros(max(size(vwindLog)), 1);
for j=1:1:nlines
    if vwindLog(j)
        vwindBin(j+1) = 1;
    end
end
vwindLog = logical(vwindBin);

% find the tline entries that contain prediction variables - output1 only
predictLog = ~cellfun(@isempty,...
    regexp(tlines,'  PREDICTION','match','once'));
predictBin = zeros(max(size(output123Log)), 1);
for j=1:1:nlines
    if predictLog(j)
        predictBin(j+2) = 1;
    end
end
predictLog = logical(predictBin);

%% Find the tline entries containing output0 bulk data
output0Log = ~cellfun(@isempty,...
    regexp(tlines,'Number  VWIND','match','once'));
output0Bin = zeros(max(size(output0Log)), 1);
record = 0;
for j=1:1:nlines
    if j > 2
        if output0Log(j-2)
            record = 1;
        end
        if record
            output0Bin(j) = 1;
        end
    end
end
output0Log = logical(output0Bin);

%% Determine number of radial stations
rstations = 0;
if fileType
    for j=1:1:nlines % for output[1-3].dat
        if  (outputLog(j) && not(outputLog(j + 1)))
            rstations = rstations + 1;
            break
        elseif outputLog(j)
            rstations = rstations + 1;
        end
    end
else
    rstations = sum(double(output0Bin)); % for output0
end

%% Load parsed xturb data file into structure
s.fileType = fileType;
s.output1logical = outputLog;
s.output123logical = output123Log;
s.vwindlogical = vwindLog;
s.predictionlogical = predictLog;
s.output0logical = output0Log;
s.rstations = rstations;

%% Debug

%% Return
asdf = s;