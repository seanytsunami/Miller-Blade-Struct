function asdf = xturbreader(filePath)

%{
    Function: xturbreader(filePath)

    Purpose: Extract data from "XTurb_Output[_-3].dat" and write to .csv

    Parameters:
    - filePath (string specifying file path of output file)

    Returns: 
    - endtable (all data extracted, with headers)
    - fileName (generated file name)

    Dependencies:
    - xturbparser.m
    - matrixloader.m
    - matrixformatter.m

    Notes:
    - COMPATIBLE WITH XTurb-PSU-g77 ONLY [other versions untested]

    TO DO:
    - Differentiate radial stations from prediction mode test cases for
    output0
        - for matrixloader, which can't tell the difference
        - will be important if xturbreader is changed to read all xturb
        output files
%}

%% Initial variables
f = filePath;

% define variable headers
output0 = ["VWIND[m/s]", "RPM[1/min]", "TSR", "PITCH[deg]", "CT", "CP",...
    "CB", "T[N]", "P[W]", "TO[Nm]", "BE[Nm]"];
output123 = ["TSR", 'PITCH [deg]', 'CT', 'CP', 'CPV', 'CB', 'CBV'];
output1 = ["r/R", 'Chord/R', 'Twist [deg]', 'AOA [deg]', 'PHI [deg]',...
    'CL',...
    'CD', 'CL/CD', 'VSEC', 'VSECX', 'VSECY', 'VSECZ', 'Re'];
output2 = ["r/R", 'Chord/R', 'Twist [deg]', 'AOA [deg]', 'CL', 'CD',...
    'CDP', 'CM', 'CThrust', 'CTorque', 'CNormal', 'CTangen'];
output3 = ["r/R", 'Chord/R', 'Twist [deg]', 'AOA [deg]', 'PHI [deg]',...
    'CL', 'CD', 'CL/CD', 'CThrust', 'CThrustV', 'CTorque', 'CTorqueV',...
    'CBending', 'CBendingV'];
vwind = ["VWIND [m/s]", "RPM [1/m]", "PITCH [deg]"];
predict = ["BRADIUS [m]", "RHOAIR [kg/m**3]", "MUAIR [kg/(m*s)]"];

%% Open file
fid = fopen(f);

%% Read output file line-by-line, assigns tline to cell array tlines
nlines = 0;
tline = fgetl(fid);
tlines = cell(0,1);

% read through data file
while ischar(tline)
    % increment counter
    nlines = nlines + 1;
    
    % load current tline into column vector tlines
    tlines{end+1,1} = tline;
    
    % increment tline
    tline = fgetl(fid);
end

%% Use xturbparser to find data locations from tlines
s = xturbparser(tlines, nlines); % struct return

%% Alter values based on file type
% define variable header sizes and specify which header to use
headersize = NaN;
switch s.fileType
    case 0
        headersize = 11;
        outputHeader = output0;
    case 1
        headersize = 13;
        outputHeader = output1;
    case 2
        headersize = 12;
        outputHeader = output2;
    case 3
        headersize = 14;
        outputHeader = output3;
end

%% Determine what to do based upon xturb output file type (s.fileType)
if s.fileType
    %% For output[1-3]
    % load bulk data (see headers)
    dlines = matrixloader(tlines, s.outputlogical, headersize);
    
    % load output123 data (see header)
    O123lines = matrixloader(tlines, s.output123logical, 7);
    
    % load vwind, rpm, pitch data
    vwindlines = matrixloader(tlines, s.vwindlogical, 3);
    
    % load prediction data (see header)
    predictlines = matrixloader(tlines, s.predictionlogical, 3);
    
    % format certain matrices to match bulk data
    O123linesF = matrixformatter(O123lines, dlines, s.rstations);
    vwindlinesF = matrixformatter(vwindlines, dlines, s.rstations);
    predictlinesF = matrixformatter(predictlines, dlines, s.rstations);
    
    % finalize headers and numbers
    headers = [vwind(:, 1:2), output123, outputHeader];
    numbers = [vwindlinesF(:, 1:2), O123linesF, dlines];
else
    %% For output0
    % load identified bulk data into output matrix
    output0lines = matrixloader(tlines, s.output0logical, headersize);
    
    % finalize headers and numbers
    headers = [outputHeader];
    numbers = [output0lines];
end

%% Add prediction parameters for Output1 (specific to output1)
if s.fileType == 1
    headers = [predict, headers];
    numbers = [predictlinesF, numbers];
end

%% Finalize outputs
endmatrix = [headers; numbers];
endtable = cell2table(num2cell(numbers),'VariableNames', headers);

%% Prepare output .csv file name
% create strings
mode = "Prediction";
JX = string(s.rstations);
% ^^^ JX unused until radial stations differentiated from test cases
outputType = string(s.fileType);
if not(s.fileType)
    outputType = "";
end

% identify airfoil name
afline = ~cellfun(@isempty,...
    regexp(tlines,'***** XTurb-PSU ','match','once'));
for j=1:1:nlines
    if afline(j)
        afchar = regexp(string(tlines(j)),'[^\s]','match')';
    end
end
afname = "";
for j=1:1:max(size(afline))
    if afchar(j) == "*"
        break
    end
    afname = strcat(afname, afchar(j));
end

%% Create file name
% contatenate file name elements
fileName = strcat(afname, "_", mode, "_", "Output", outputType);
checkName = strcat(fileName, ".csv");

% check if file with same name exists, adjust by adding ... (1-9999)...
if isfile(checkName)
    for j=1:1:9999
        sameName = fileName;
        sameName = strcat(fileName, " ", "(", string(j), ")", ".csv");
        if not(isfile(sameName))
            fileName = strcat(fileName, " ", "(", string(j), ")");
            break
        end
    end
end

%% Write endtable to .csv
fileName = strcat(fileName, ".csv"); % file type

%% Load endtable and filaName to structure
s.endtable = endtable;
s.fileName = fileName;

%% Close file
fclose(fid);

%% Debug

%% Return
asdf = s;
end