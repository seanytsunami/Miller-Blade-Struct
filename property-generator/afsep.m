function asdf = afsep(af)

%{
    Function: afsep(af)

    Purpose: Separates the upper and lower surfaces of an input airfoil
    geometry

    Parameters: af (airfoil geometry)

    Returns: 
    - upper (upper surface of the airfoil)
    - lower (lower surface of the airfoil)
    
    Dependencies:

    Notes: 
    - The airfoil input file must be ORDERED with the UPPER SURFACE FIRST
    in order for foilSep to work

    TO DO:
%}

%% Separate airfoil surfaces
% define loop iterations
nj = max(size(af));

if rem(nj, 2) == 1
    mid = ((nj)/2 + 0.5);
    upper = flipud(af(1:mid, :));
    lower = af(mid:nj, :);
else
    mid = (nj)/2;
    upper = flipud(af(1:mid, :));
    lower = af(mid+1:nj, :);
end

%% Return
asdf = [upper, lower]; % [nj, nj, nj ,nj], [chord, upper, chord, lower]