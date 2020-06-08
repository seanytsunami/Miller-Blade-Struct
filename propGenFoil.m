function asdf = propGenFoil(af, c, beta)

%{
    Function: propGenFoil(af, c, beta)

    Purpose: Find section area moments of inertias in Z (flapwise) and Y
    (edgewise) directions

    Parameters: af (airfoil geometry), c (chord at each span), beta (twist
    at each span)

    Returns: IzzS, IyyS (second area moments of inertias at each point
    along the span)

    Notes: Adjust input parameters so they give data at each point along
    the span

    TO DO: incorporate twist, chord length per section
%}

%% Method for calculating area moment of inertia
% - "Riemann" discretization of airfoil geometry
% - Split airfoil into rectangles and find individual moments of inertia
% - Use a weighted average to find the total moment of inertia for that
% airfoil section
% - Account for section chord by scaling the airfoil with chord length
% - Account for sectional twist by using a coordinate system transformation
% - Do this for all airfoil sections along the blade/wing span

%% Initial variables
% define matrix sizes and loop iterations
nj = max(size(af));
mid = ((nj)/2 + 0.5);

% separate airfoil geometry file into upper and lower surfaces
upper = flipud(af(1:mid, :));
lower = af(mid:nj, :);

% initialize Z and Y neutral axes
zbar = 0; 
ybar = 0;

% initialize arrays
Izzn = zeros(mid, 1); % moment of inertia for each rectangle
Iyyn = zeros(mid, 1);

An = zeros(mid-1, 1); % area for each rectangle

zbarn = zeros(mid-1, 1); % centroid for each rectangle
ybarn = zeros(mid-1, 1);

IzzS = 0; % total moment of inertia for each airfoil section
IyyS = 0;

%% Calculate rectangular moments of inertia and intermediate values
for j=1:1:mid-1
    % calculate rectangle base and height
    b = upper(j+1, 1) - upper(j, 1); 
    h = upper(j+1, 2) - lower(j+1, 2);
    
    % calculate area of rectangle
    An(j) = b*h; 
    
    % calculate centroid of each individual rectangle
    zbarn(j) = (upper(j+1, 2) + lower(j+1, 2))/2; 
    ybarn(j) = (upper(j+1, 1) + upper(j, 1))/2;
    
    % update numerator for neutral axis calculation
    zbar = zbar + ((b*h)*(zbarn(j))); 
    ybar = ybar + ((b*h)*(ybarn(j)));
    
    % calculate rectangle moments of inertia
    Izzn(j) = (h*b^3)/12; 
    Iyyn(j) = (b*h^3)/12;
end

%% Calculate neutral axes locations
zbar = zbar/sum(An, 'all');
ybar = ybar/sum(An, 'all');

%% Calculate total moment of inertia from composite rectangles
for j=1:1:mid-1
    IzzS = IzzS + (Izzn(j) + ((An(j))*abs((ybarn(j)) - ybar)^2));
    IyyS = IyyS + (Iyyn(j) + ((An(j))*abs((zbarn(j)) - zbar)^2)); 
end

%% Transform sectional moment of inertia
IzzSX = (IyyS + IzzS)/2 - (IyyS - IzzS)/2*cos(2*beta);
IyySX = (IyyS + IzzS)/2 + (IyyS - IzzS)/2*cos(2*beta);

%% Debug

%% Return
asdf = [IzzS, IyyS];