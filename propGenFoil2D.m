function asdf = propGenFoil2D(af, naf, c, beta)

%{
    Function: propGenFoil2D(af, naf, c, beta)

    Purpose: Find section area moments of inertias in Z (flapwise) and Y
    (edgewise) directions AND product of inertia, 
    
    *** propGenFoil2D supports thin walls, spars, and solid ribs ONLY ***

    Parameters: af (airfoil geometry), naf (negative geometry), (chord at
    each span), beta (twist at each span)

    Returns: IzzSX, IyySX, IyzSX (product and area moments of inertia at
    each station along span/radius)

    Notes: 

    TO DO: work in progress
%}

%% Method for calculating area moment of inertia
% - "Riemann" discretization of airfoil geometry
% - Split airfoil into rectangles using 'af' along the chord
% - Subtract negative space ('naf') from the rectangles and calculate the
% moment of inertia
% - Use a weighted average to find the total moment of inertia for that
% airfoil section
% - Account for section chord by scaling the airfoil with chord length
% - Account for sectional twist by using a coordinate system transformation
% - Do this for all airfoil sections along the blade/wing span

%% Pseudo exception handling
if max(size(c)) ~= max(size(beta))
    disp('The sizes of c and beta do not match. Exiting function...')
    asdf = [NaN, NaN, NaN];
    return
end

%% Initial variables
% define matrix sizes and loop iterations
nj = max(size(af));
mid = ((nj)/2 + 0.5);
span = max(size(c));

% separate airfoil geometry file into upper and lower surfaces
upper = flipud(af(1:mid, :));
lower = af(mid:nj, :);

% separate negative geometry file into up and lower 
nupper = flipud(naf(1:mid, :));
nlower = naf(mid:nj, :);

% initialize arrays
Izzn = zeros(mid, 1); % moment of inertia for each rectangle
Iyyn = zeros(mid, 1);
nIzzn = zeros(mid, 1); % moment of inertia of negative space
nIyyn = zeros(mid, 1);
TotIzzn = zeros(mid, 1); % moment of inertia of composite rectangles
TotIyyn = zeros(mid, 1);

An = zeros(mid-1, 1); % area for each rectangle
nAn = zeros(mid-1, 1); % area of negative space
TotAn = zeros(mid-1, 1); % total area of composite rectangles

zbarn = zeros(mid-1, 1); % centroid for each rectangle
ybarn = zeros(mid-1, 1);
nzbarn = zeros(mid-1, 1); % centroid of negative space
nybarn = zeros(mid-1, 1);
Totzbarn = zeros(mid-1, 1); % centroid of composite rectangles
Totybarn = zeros(mid-1, 1);

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
    upperc = upper.*c(k);
    lowerc = lower.*c(k);
    
    nupperc = nupper.*c(k); % negative space
    nlowerc = nlower.*c(k);
    
    %% Calculate rectangular moments of inertia and intermediate values
    for j=1:1:mid-1
        % calculate rectangle base and height
        b = upperc(j+1, 1) - upperc(j, 1);
        h = (upperc(j, 2) - lowerc(j, 2)...
            + upperc(j+1, 2) - lowerc(j+1, 2))/2;
        nb = nupperc(j+1, 1) - nupperc(j, 1); % negative space
        nh = (nupperc(j, 2) - nlowerc(j, 2)...
            + nupperc(j+1, 2) - nlowerc(j+1, 2))/2;
        
        % calculate area of rectangle
        An(j) = b*h;
        nAn(j) = nb*nh; % negative space
        TotAn(j) = An(j) - nAn(j); % composite area
        
        % calculate centroid of each individual rectangle
        zbarn(j) = (upperc(j+1, 2) + lowerc(j+1, 2))/2;
        ybarn(j) = (upperc(j+1, 1) + upperc(j, 1))/2;
        nzbarn(j) = (nupperc(j+1, 2) + nlowerc(j+1, 2))/2; % negative space
        nybarn(j) = (nupperc(j+1, 1) + nupperc(j, 1))/2;
        
        % calculate centroid of composite rectangles
        Totzbarn(j) = (zbarn(j)*An(j) - nzbarn(j)*nAn(j))/TotAn(j);
        Totybarn(j) = (ybarn(j)*An(j) - nybarn(j)*nAn(j))/TotAn(j);
        
        % update numerator for neutral axis calculation
        zbar = zbar + (TotAn(j)*Totzbarn(j));
        ybar = ybar + (TotAn(j)*Totybarn(j));
        
        % calculate rectangle moments of inertia
        Izzn(j) = (h*b^3)/12;
        Iyyn(j) = (b*h^3)/12;
        nIzzn(j) = (nh*nb^3)/12; % negative space
        nIyyn(j) = (nb*nh^3)/12;
        
        % calculate moment of inertia of composite rectangles
        TotIzzn(j) = (Izzn(j) + ((An(j))*abs((ybarn(j)) - Totybarn(j))^2))...
            - (nIzzn(j) + ((nAn(j))*abs((nybarn(j)) - Totybarn(j))^2));
        TotIyyn(j) = (Iyyn(j) + ((An(j))*abs((zbarn(j)) - Totzbarn(j))^2))...
            - (nIyyn(j) + ((nAn(j))*abs((nzbarn(j)) - Totzbarn(j))^2));
    end
    
    %% Calculate neutral axes locations
    zbar = zbar/sum(TotAn, 'all');
    ybar = ybar/sum(TotAn, 'all');
    
    %% Calculate total product and moments of inertia from composite rectangles
    for j=1:1:mid-1
        % calculate product of inertia
        IyzS(k) = IyzS(k) + (TotAn(j)*(Totybarn(j) - ybar)*(Totzbarn(j) - zbar));
        
        % calculate moments of inertia
        IzzS(k) = IzzS(k) + (TotIzzn(j) + ((TotAn(j))*abs((Totybarn(j)) - ybar)^2));
        IyyS(k) = IyyS(k) + (TotIyyn(j) + ((TotAn(j))*abs((Totzbarn(j)) - zbar)^2));
    end
    
    %% Transform sectional product and moments of inertia
    IzzSX(k) = (IyyS(k) + IzzS(k))/2 - (IyyS(k) - IzzS(k))/2*cos(2*beta(k))...
        + IyzS(k)*sin(2*beta(k));
    IyySX(k) = (IyyS(k) + IzzS(k))/2 + (IyyS(k) - IzzS(k))/2*cos(2*beta(k))...
        - IyzS(k)*sin(2*beta(k));
    
    IyzSX(k) = (IyyS(k) -  IzzS(k))/2*sin(2*beta(k)) + IyzS(k)*cos(2*beta(k));
    
end
%% Debug

%% Return
asdf = [IzzSX, IyySX, IyzSX];