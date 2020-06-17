function asdf = compositemoi(Izzn, Iyyn, An, zbarn, ybarn)

%{
    Function: compositemoi(Izzn, Iyyn, An, zbarn, ybarn)

    Purpose: Finds the composite product and moments of inertia in 2
    dimensions given Areas, individual moments of inertia, and centroids.
    This function assumes rectangular shapes in the composite moi
    calculation.

    Parameters: Izzn, Iyyn (rectangle moments of inertia), An (rectangle
    areas), zbarn, ybarn (centroid locations for rectangles)

    Returns: Izz, Iyy (area moments of inertia), Iyz (product of inertia)

    Notes:
    - ASSUMES INPUT GEOMETRIES ARE RECTANGULAR (works with propGenFoil.m)
%}

%% Initial variables
% define loop iterations
mid = max(size(Izzn));

% initialize product and moments of inertia
Iyz = 0;
Izz = 0;
Iyy = 0;

% initialize neutral axes
zbar = 0;
ybar = 0;

%% Update numerator for neutral axis calculation
for j=1:1:mid-1
    zbar = zbar + (An(j)*(zbarn(j)));
    ybar = ybar + (An(j)*(ybarn(j)));
end

%% Calculate neutral axes
zbar = zbar/sum(An, 'all');
ybar = ybar/sum(An, 'all');

%% Calculate total product and moments of inertia from composite rectangles
for j=1:1:mid-1
    % calculate product of inertia
    Iyz = Iyz + (An(j)*(ybarn(j) - ybar)*(zbarn(j) - zbar));
    
    % calculate moments of inertia
    Izz = Izz + (Izzn(j) + ((An(j))*abs((ybarn(j)) - ybar)^2));
    Iyy = Iyy + (Iyyn(j) + ((An(j))*abs((zbarn(j)) - zbar)^2));
end

%% Debug

%% Return
asdf = [Izz, Iyy, Iyz];