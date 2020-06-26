function asdf = afinterp(af, method)

%{
    Function: foilinterp(af)

    Purpose: Interpolates points on the upper and lower surfaces of an
    input airfoil file and the separates the upper and lower surfaces in
    the output file

    Parameters:
    - af (raw airfoil data file OR file path)
    - method (method of interpolation)

    Returns:
    - x (stations along non-dimensionalized chord)
    - uinterp (interpolated upper surface)
    - linterp (interpolated lower surface)

    Dependencies:
    - foilSep.m

    Notes:
    - Functionally, this is a more feature rich version of foilSep.m
    - This function is not a pure interpolation, it combines methods of
    interpolation to create a more usable interpolated curve

    TO DO:
%}

%% Check if input is file path, convert to array if necessary
if isstring(af) || ischar(af)
    af = table2array(readtable(af));
end

%% Separate airfoil into lower and upper surfaces
afs = foilSep(af);

%% Interpolate upper and lower surfaces
% set discretization size
x = linspace(0, 1, 1000);

% interpolate based upon input parameter 'method' and reference linear
uinterp = interp1(afs(:,1), afs(:, 2), x, 'linear');
linterp = interp1(afs(:,3), afs(:, 4), x, 'linear');
uinterpm = interp1(afs(:,1), afs(:, 2), x, method);
linterpm = interp1(afs(:,3), afs(:, 4), x, method);

% create combined interpolated matrix between 'method' and linear
% (helpful when non-endpoint zero values appear in the input geometry file)
for j=1:1:length(x)
    if uinterp(j)
        uinterp(j) = uinterpm(j);
    end
    if linterp(j)
        linterp(j) = linterpm(j);
    end
end

%% Debug

%% Return
asdf = [x', uinterp', x', linterp'];