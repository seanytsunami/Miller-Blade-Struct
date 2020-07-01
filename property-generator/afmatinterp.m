function asdf = afmatinterp(afm, method)

%{
    Function: afmatinterp(dirPath)

    Purpose: From a matrix of airfoil geometies... interpolates and 
    separates the upper/lower surfaces of each airfoil, then loads the
    processed data into a combined output matrix.

    Parameters:
    - afm (double matrix containing airfoil geometries)
    - method (interpolation method)

    Returns:
    - afmsi (double matrix containing all airfoil geometries separated into
    upper and lower surfaces and interpolated)

    Dependencies:
    - afinterp.m

    Notes:

    TO DO:
%}

%% Initial variables
% create empty separated airfoil matrix
afmsi = NaN(1000, length(afm(1, :)*2));

%% Separate airfoils in afm into upper/lower surfaces and interpolates
index = 1; % index to allow for 4-column-wide loading of matrix
jndex = 1; % second index because afsep needs 2-column-wide input

for j=1:1:length(afm(1,:))/2 % (# of columns in afm)/2 = # of airfoils
    % truncate NaNs from chord and upper/lower surface data for afsep.m
    x = afm(:, jndex);
    x(~any(~isnan(x), 2),:)=[];
    y = afm(:, jndex+1);
    y(~any(~isnan(y), 2),:)=[];
    
    % separate airfoil into upper/lower surfaces, assign to z
    z = afinterp([x, y], method);
    
    % load matrix with separated, interpolated airfoil values
    afmsi(:, index:index+3) = z;
    
    % increment indices
    index = index + 4;
    jndex = jndex + 2;
end

%% Return
asdf = afmsi;