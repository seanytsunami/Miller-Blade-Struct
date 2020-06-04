function asdf = propGenFoil(af, c, beta)

%{
  Function: propGenFoil(af, c, beta)
  
  Purpose: Find section second area moments of inertias in Z and Y
  directions (or Y and X directions, repectively)
  
  Parameters: af (airfoil geometry), c (chord at each span), beta (twist)
  
  Returns: IzzS, IyyS (second area moments of inertias at each point along
  span)
  
  Notes:
    
  TO DO: incorporate twist, chord length per section
%}

%% Initial Variables
% matrix sizes
nj = max(size(af));
mid = ((nj)/2 + 0.5);
span = 1; % THIS NEEDS TO BE USER DEFINED, SPAN DISCRETIZATION

% initialize arrays
upper = zeros(mid, 2);
lower = zeros(mid, 2);

IzzD = zeros(mid, 1); % discretization for each section
IyyD = zeros(mid, 1);

IzzS = 0; % total I for each section
IyyS = 0;

Izz = zeros(span); % array of total sectional inertias for Z and Y
Iyy = zeros(span);

% separating airfoil geometry file
upper = flipud(af(1:mid, :));
lower = af(mid:nj, :);


%% Calculating 2nd Area Moment of Inertia
% "riemann" discretization of airfoil geometry
% split into rectangles and weighted average to find MOI per section of af

% for single section
zbar = 0; % Z and Y neutral axes
ybar = 0;
An = zeros(mid-1); % area for each rectangle (used in neutral axis calculation)

for j=1:1:mid-1
    b = upper(j+1, 1) - upper(j, 1); % calc. rectangle base and height
    h = upper(j+1, 2) - lower(j+1, 2);
    
    An(j) = b*h; % Area of particular slice
    
    zj = (upper(j+1, 2) + lower(j+1, 2))/2; % midpoint of each individual rectangle
    yj = (upper(j+1, 1) + upper(j, 1))/2;
    
    zbar = zbar + ((b*h)*(zj)); % calculate numerator of neutral axis
    ybar = ybar + ((b*h)*(yj));
    
    IzzD(j) = (h*b^3)/12 % calculating MOI
    IyyD(j) = (b*h^3)/12
    
end

zbar = zbar/sum(An, 'all'); % actual neutral axis calculation
ybar = ybar/sum(An, 'all'); 

% average MOI from composite rectangles
for j=1:1:mid-1
    b = upper(j+1, 1) - upper(j, 1); % calc. b & h (again)
    h = upper(j+1, 2) - lower(j+1, 2);
    
    zj = (upper(j+1, 2) + lower(j+1, 2))/2; % midpoint of each individual rectangle (again)
    yj = (upper(j+1, 1) + upper(j, 1))/2;
    
    IzzS = IzzS + (IzzD(j) + ((b*h)*abs((yj) - ybar)^2)); % calc. MOI
    IyyS = IyyS + (IyyD(j) + ((b*h)*abs((zj) - zbar)^2));
    
    IzzSX = (IyyS + IzzS)/2 - (IyyS - IzzS)/2*cos(2*beta); % xformed MOI
    IyySX = (IyyS + IzzS)/2 + (IyyS - IzzS)/2*cos(2*beta);
end

IzzS; % total Z and Y second area moment of inertias
IyyS;

asdf = [IzzS, IyyS];