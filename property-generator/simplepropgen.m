function asdf = simplepropgen(af, c, beta)

%{
    Function: propGenFoil(af, c, beta)

    Purpose: Find section area moments of inertias in Z (flapwise) and Y
    (edgewise) directions AND product of inertia

    Parameters: 
    - af (airfoil geometry)
    - c (chord at each span)
    - beta (twist at each span)

    Returns:
    - rR (non-dimensionalized radial position or span location)
    - IzzSX (flapwise area moment of inertia at radial/spanwise locations)
    - IyySX (edgewise ---------------------- " ----------------------)
    - IyzSX (product of inertia at radial/spanwise locations)
    - c (chord, same as input)
    - beta (twist, same as input)

    Dependencies:
    - afsep.m

    Notes: 

    TO DO:
%}

%% Method for calculating area moment of inertia
% - "Riemann" discretization of airfoil geometry
% - Split airfoil into rectangles and find individual moments of inertia
% - Use a weighted average to find the total moment of inertia for that
% airfoil section
% - Account for section chord by scaling the airfoil with chord length
% - Account for sectional twist by using a coordinate system transformation
% - Do this for all airfoil sections along the blade/wing span

%% Check if af, c, or beta is a matrix or file path
if isstring(af) || ischar(af)
    af = strip(af, 'left', '/');
    af = getafdata(af);
end
if isstring(c) || ischar(c)
    c = strip(c, 'left', '/');
    c = getafdata(c);
    c = [c(:,2), c(:,1)];
end
if isstring(beta) || ischar(beta)
    beta = strip(beta, 'left', '/');
    beta = getafdata(beta);
    beta = [beta(:,2), beta(:,1)];
end

%% Pseudo exception handling
if max(size(c)) ~= max(size(beta))
    disp('The sizes of c and beta do not match. Exiting function...')
    asdf = [NaN, NaN, NaN, NaN];
    return
end

%% Initial variables
% define matrix sizes and loop iterations
nj = max(size(af));
mid = (nj)/2;
if rem(max(size(af)), 2) == 1
    mid = ((nj)/2 + 0.5);
end
span = max(size(c));

% resolve r/R output variable
if max(size(c)) == 1
    rR = 0;
else
    rR = c(:, 2);
end

% separate airfoil geometry file into upper and lower surfaces
afs = afsep(af);
upper = afs(:, 1:2);
lower = afs(:, 3:4);

% initialize arrays
Izzn = zeros(mid, 1); % moment of inertia for each rectangle
Iyyn = zeros(mid, 1);

An = zeros(mid-1, 1); % area for each rectangle
TotASec = zeros(span, 1); % total area of airfoil section

zbarn = zeros(mid-1, 1); % centroid for each rectangle
ybarn = zeros(mid-1, 1);

IzzS = zeros(span, 1); % total moments of inertia for each airfoil section
IyyS = zeros(span, 1);
IyzS = zeros(span, 1); % product of inertia for each airfoil section

IzzSX = zeros(span, 1); % total moments of inertia for each airfoil section
IyySX = zeros(span, 1);
IyzSX = zeros(span, 1); % product of inertia for each airfoil section

%% Loop through span/radial stations
for k=1:1:span

% initialize/redefine Z and Y neutral axes
zbar = 0;
ybar = 0;

    %% Scale airfoil by chord length
    upperc = upper.*c(k, 1);
    lowerc = lower.*c(k, 1);
    
    %% Calculate rectangular moments of inertia and intermediate values
    for j=1:1:mid-1
        % calculate rectangle base and height
        b = upperc(j+1, 1) - upperc(j, 1);
        h = (upperc(j, 2) - lowerc(j, 2)...
            + upperc(j+1, 2) - lowerc(j+1, 2))/2;
        
        % calculate area of rectangle
        An(j) = b*h;
        
        % calculate centroid of each individual rectangle
        zbarn(j) = (upperc(j, 2) + lowerc(j, 2)...
            + upperc(j+1, 2) + lowerc(j+1, 2))/4;
        ybarn(j) = (upperc(j+1, 1) + upperc(j, 1))/2;
        
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
    
    %% Airfoil section area
    TotASec(k) = sum(An, 'all');
    
    %% Calculate total product and moments of inertia from composite rectangles
    for j=1:1:mid-1
        % calculate product of inertia
        IyzS(k) = IyzS(k) + (An(j)*(ybarn(j) - ybar)*(zbarn(j) - zbar));
        
        % calculate moments of inertia
        IzzS(k) = IzzS(k) + (Izzn(j) + ((An(j))*abs((ybarn(j)) - ybar)^2));
        IyyS(k) = IyyS(k) + (Iyyn(j) + ((An(j))*abs((zbarn(j)) - zbar)^2));
    end
    
    %% Transform sectional product and moments of inertia
    IzzSX(k) = (IyyS(k) + IzzS(k))/2 - (IyyS(k) - IzzS(k))/2*cos(2*beta(k, 1))...
        + IyzS(k)*sin(2*beta(k, 1));
    IyySX(k) = (IyyS(k) + IzzS(k))/2 + (IyyS(k) - IzzS(k))/2*cos(2*beta(k, 1))...
        - IyzS(k)*sin(2*beta(k, 1));
    
    IyzSX(k) = (IyyS(k) -  IzzS(k))/2*sin(2*beta(k, 1)) + IyzS(k)*cos(2*beta(k, 1));
    
end
%% Debug

%% Return
asdf = [rR, IzzSX, IyySX, IyzSX, TotASec, c(:,1), beta(:,1)];