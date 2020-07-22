function s = xturbinp(f)

%{
    Function: xturbinp(f)

    Purpose: Extract data from XTurb input file

    Parameters:
    - f (string specifying file path of input file)

    Returns: 
    - Structure containing:
    - s.name (airfoil name)
    - s.ntaper (number of defined taper points)
    - s.taperdistr (taper at defined points)
    - s.taperdistrinterp (taper interpolated at radial stations)
    - s.ntwist (same as above but for twist)
    - s.twistdistr (-- " --)
    - s.twistdistrinterp (-- " --)
    - s.jx (no. of radial stations)
    - s.cosdistr (type of distribution to use, 0 = linear, 1 = cosdistr)

    Dependencies:

    Notes:
    - COMPATIBLE WITH XTurb-PSU-g77 ONLY [other versions untested]

    TO DO:
%}

%% Initial variables
s = struct;
d2r = pi/180;

%% Open file
fid = fopen(f);

%% Read output file line-by-line, assigns tline to cell array tlines
nlines = 0;
tline = fgetl(fid);
tlines = cell(0,1);

% read through data file
while ischar(tline)
    nlines = nlines + 1; % increment counter
    tlines{end+1,1} = tline; % load current tline into tlines
    tline = fgetl(fid); % increment tline
end

%% Parse
for j=1:1:nlines
    % find airfoil name
    if ~cellfun(@isempty, regexp(tlines(j),' Name ','match','once'))
        s.name = join(regexp(string(tlines(j)),'[^\s]','match'));
    end
    % find ntaper
    if ~cellfun(@isempty, regexp(tlines(j),'NTAPER','match','once'))
        s.ntaper = double(string(regexp(tlines(j),'\d+','match')));
        s.taperdistr = zeros(s.ntaper, 2);
    end
    % load radial pos into taper distribution
    if ~cellfun(@isempty, regexp(tlines(j),'RTAPER','match','once'))
        for k=j:1:j+s.ntaper-1
            s.taperdistr(k-j+1, 1) = double(string(regexp(tlines(k),...
                '(\-?\d*\.\d*)','match')));
        end
    end
    % load taper into taper distribution
    if ~cellfun(@isempty, regexp(tlines(j),'CTAPER','match','once'))
        for k=j:1:j+s.ntaper-1
            s.taperdistr(k-j+1, 2) = d2r*double(string(regexp(tlines(k),...
                '(\-?\d*\.\d*)','match')));
        end
    end
    % find ntwist
    if ~cellfun(@isempty, regexp(tlines(j),'NTWIST','match','once'))
        s.ntwist = double(string(regexp(tlines(j),'\d+','match')));
        s.twistdistr = zeros(s.ntwist, 2);
    end
    % load radial pos into twist distribution
    if ~cellfun(@isempty, regexp(tlines(j),'RTWIST','match','once'))
        for k=j:1:j+s.ntwist-1
            s.twistdistr(k-j+1, 1) = double(string(regexp(tlines(k),...
                '(\-?\d*\.\d*)','match')));
        end
    end
    % load twist into twist distribution
    if ~cellfun(@isempty, regexp(tlines(j),'DTWIST','match','once'))
        for k=j:1:j+s.ntwist-1
            s.twistdistr(k-j+1, 2) = d2r*double(string(regexp(tlines(k),...
                '(\-?\d*\.\d*)','match')));
        end
    end
    % find jx -- radial stations
    if ~cellfun(@isempty, regexp(tlines(j),'JX','match','once'))
        s.jx = double(string(regexp(tlines(j),'\d+','match')));
    end
    % find cosdistr -- 0 means linear, 1 means cosine
    if ~cellfun(@isempty, regexp(tlines(j),'COSDISTR','match','once'))
        s.cosdistr = double(string(regexp(tlines(j),'\d+','match')));
    end
end

%% Process
s.name = erase(strrep(s.name, ' ', ""), ["Name=", "'", ","]);
if s.cosdistr % interpolation type
    xqtaper = cosspace(min(s.taperdistr(:,1)), max(s.taperdistr(:,1)), s.jx);
    xqtwist = cosspace(min(s.twistdistr(:,1)), max(s.twistdistr(:,1)), s.jx);
else
    xqtaper = linspace(min(s.taperdistr(:,1)), max(s.taperdistr(:,1)), s.jx);
    xqtwist = linspace(min(s.twistdistr(:,1)), max(s.twistdistr(:,1)), s.jx);
end
s.taperdistrinterp =...
    [xqtaper', interp1(s.taperdistr(:,1), s.taperdistr(:,2),...
    xqtaper, 'linear', 'extrap')'];
s.twistdistrinterp =...
    [xqtwist', interp1(s.twistdistr(:,1), s.twistdistr(:,2),...
    xqtwist, 'linear', 'extrap')'];
