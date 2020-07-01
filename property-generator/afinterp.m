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
    - afsep.m
    - getafdata.m

    Notes:
    - Functionally, this is a more feature rich version of afsep.m
    - This function is not a pure interpolation, it combines methods of
    interpolation to create a more usable interpolated curve

    TO DO:
%}

%% Check if input is file path, convert to array if necessary
if isstring(af) || ischar(af)
    af = getafdata(af);
end

%% Separate airfoil into lower and upper surfaces
afs = afsep(af);

%% Interpolate upper and lower surfaces
% set discretization size
x = linspace(0, 1, 1000);

% interpolate based upon input parameter 'method' and reference linear
uinterp = interp1(afs(:,1), afs(:, 2), x, 'linear');
linterp = interp1(afs(:,3), afs(:, 4), x, 'linear');
uinterpm = interp1(afs(:,1), afs(:, 2), x, method);
linterpm = interp1(afs(:,3), afs(:, 4), x, method);

%% Create combined interpolated matrix between 'method' and linear
%(needed when non-endpoint zero values appear in the input geometry file)
for j=1:1:length(x)
    % check if NaN appears in any interpolations, if so set to 0
    if isnan(uinterp(j))
        uinterp(j) = 0;
    end
    if isnan(linterp(j))
        linterp(j) = 0;
    end
    if isnan(uinterpm(j))
        uinterpm(j) = 0;
    end
    if isnan(linterpm(j))
        linterpm(j) = 0;
    end
    
    % replace values
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