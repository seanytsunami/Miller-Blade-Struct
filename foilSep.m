function asdf = foilSep(af)

%{
    Function: foilSep(af)

    Purpose: Separates the upper and lower surfaces of an input airfoil
    geometry

    Parameters: af (airfoil geometry... MUST BE ODD # stations)

    Returns: upper, lower (upper and lower surfaces of the airfoil)

    Notes: 
%}

%% Separate airfoil surfaces
% define loop iterations and midpoint
nj = max(size(af));
mid = ((nj)/2 + 0.5);

% separate airfoil geometry file into upper and lower surfaces
upper = flipud(af(1:mid, :));
lower = af(mid:nj, :);

%% Return
asdf = [upper, lower]; % [nj, nj, nj ,nj], [chord, upper, chord, lower]