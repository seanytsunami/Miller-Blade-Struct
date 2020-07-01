function asdf = afpropgen(af, naf, c, beta)

%{
    Function: afpropgen(af, naf, c, beta)

    Purpose: Find section area moments of inertias in Z (flapwise) and Y
    (edgewise) directions AND product of inertia. Compatible with solid
    airfoils as well as complex geometries

    Parameters:
    - af (airfoil geometry)
    - naf (negative geometry)
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
    - afinterp.m (interpolates and separates single airfoil file)
    - afmatinterp.m (--- " --- multiple airfoils in one array)
    - compositemoi.m (generators composite moments of inertia)
    - afloader.m

    Notes:
    - replaces propGenFoil.m and propGenFoil2D.m

    TO DO:
    - build in operation modes
        - case 0: partially done
    - build in varying negative space per spanwise/radial station
    - pseudo exception handling for invalid negative geometries
%}

%% Debug

%% Method for calculating area moment of inertia
% - "Riemann" discretization of airfoil geometry
% - Split airfoil into rectangles using 'af' along the chord
% - Subtract negative space ('naf') from the rectangles and calculate the
% moment of inertia of new positive/negative space
% - Use a weighted average to find the total moment of inertia for that
% airfoil section
% - Account for section chord by scaling the airfoil with chord length
% - Account for sectional twist by using a coordinate system transformation
% - Do this for all airfoil sections along the blade/wing span

%% Identify operation mode
% switch opmode
%     case 0 % self detect mode
%     case 1 % simple internal geometry (naf is single airfoil file)
%     case 2 % complex internal geometry (naf is dir path or struct)
%     case 3 % no negative space
%     case 4 % advanced user mode (FUNCTIONALITY TBD)
% end

%% Check if af, c, or beta is a matrix or file path
if isstring(af) || ischar(af)
    af = strip(af, 'left', '/');
    af = getafdata(af);
end
if isstring(c) || ischar(c)
%     c = strip(c, 'left', '/');
    c = getafdata(c);
    c = [c(:,2), c(:,1)];
end
if isstring(beta) || ischar(beta)
%     beta = strip(beta, 'left', '/');
    beta = getafdata(beta);
    beta = [beta(:,2), beta(:,1)];
end

%% Pseudo exception handling
if max(size(c)) ~= max(size(beta))
    disp('The sizes of c and beta do not match. Exiting function...')
    asdf = [NaN, NaN, NaN, NaN];
    return
end

%% Interpolate main, positive space airfoil file
method = "makima";
afsi = afinterp(af, method);

%% Load and process negative space
if ismatrix(naf)  && ~ischar(naf) % if naf is matrix (or single airfoil file)
    nafmsi = afmatinterp(naf, method);
elseif isstring(naf) || ischar(naf) % if naf is a file path
    if contains(naf, [".txt", ".csv", ".dat"])
        nafmsi = afinterp(getafdata(naf), "makima");
    else
        nafm = afloader(naf); % create airfoil matrix
        nafmsi = afmatinterp(nafm, method); % separates and interpolates airfoil matrix
    end
end
numnaf = length(nafmsi(1,:))/4; % number of negative space files

%% Initial variables
% define matrix sizes and loop iterations
nj = length(afsi(:,1));
span = max(size(c));

% resolve r/R output variable
if max(size(c)) == 1
    rR = 0;
else
    rR = c(:, 2);
end

% separate airfoil geometry file into upper and lower surfaces
upper = afsi(:, 1:2);
lower = afsi(:, 3:4);

% initialize arrays (for speed?)
Izzn = zeros(nj, 1); % moment of inertia for each rectangle
Iyyn = zeros(nj, 1);
nIzzmn = zeros(nj, numnaf); % moment of inertia of negative space
nIyymn = zeros(nj, numnaf);
TotIzzn = zeros(nj, 1); % moment of inertia of composite rectangles
TotIyyn = zeros(nj, 1);

An = zeros(nj-1, 1); % area for each rectangle
nAmn = zeros(nj-1, numnaf); % area of negative space
TotAn = zeros(nj-1, 1); % total area of composite rectangles

zbarn = zeros(nj-1, 1); % centroid for each rectangle
ybarn = zeros(nj-1, 1);
nzbarmn = zeros(nj-1, numnaf); % centroid of negative space
nybarmn = zeros(nj-1, numnaf);
Totzbarn = zeros(nj-1, 1); % centroid of composite rectangles
Totybarn = zeros(nj-1, 1);

IzzS = zeros(span, 1); % total moments of inertia for each airfoil section
IyyS = zeros(span, 1);
IyzS = zeros(span, 1); % product of inertia for each airfoil section

IzzSX = zeros(span, 1); % xformed total moi for each airfoil section
IyySX = zeros(span, 1);
IyzSX = zeros(span, 1); % xformed total poi for each airfoil section

%% Plot all geometries to verify internal geometry
plot(upper(:, 1), upper(:, 2), 'k')
hold on
plot(lower(:, 1), lower(:, 2), 'k')
index = 1; % index to read 4-column-wide negative airfoil data
for h=1:1:numnaf
    hold on
    plot(nafmsi(:, index), nafmsi(:, index+1), 'r-')
    hold on
    plot(nafmsi(:, index+2), nafmsi(:, index+3), 'r-')
    
    % increment index
    index = index + 4;
end
hold off

%% Loop through spanwise/radial stations
for k=1:1:span
    
    %% Scale airfoil by chord length
    upperc = upper.*c(k, 1);
    lowerc = lower.*c(k, 1);
    
    nafmsic = nafmsi.*c(k, 1); % negative space
    
    %% Calculate rectangular moments of inertia and intermediate values
    %% Solid airfoil
    for j=1:1:nj-1
        % area, base, and height
        b = upperc(j+1, 1) - upperc(j, 1);
        h = (upperc(j, 2) - lowerc(j, 2)...
            + upperc(j+1, 2) - lowerc(j+1, 2))/2;
        An(j) = b*h;
        
        % centroid
        zbarn(j) = (upperc(j, 2) + lowerc(j, 2)...
            + upperc(j+1, 2) + lowerc(j+1, 2))/4;
        ybarn(j) = (upperc(j+1, 1) + upperc(j, 1))/2;
        
        % moments of inertia
        Izzn(j) = (h*b^3)/12;
        Iyyn(j) = (b*h^3)/12;
    end
    
    %% Negative space (from matrix)
    index = 1;
    for h=1:1:numnaf
        for j=1:1:nj-1
            % area, base, and height
            nbm = nafmsic(j+1, index) - nafmsic(j, index);
            nhm = (nafmsic(j, index+1) - nafmsic(j, index+3)...
                + nafmsic(j+1, index+1) - nafmsic(j+1, index+3))/2;
            nAmn(j, h) = nbm*nhm;
            
            % centroid
            nzbarmn(j, h) = (nafmsic(j, index+1) + nafmsic(j, index+3)...
                + nafmsic(j+1, index+1) + nafmsic(j+1, index+3))/4;
            nybarmn(j, h) = (nafmsic(j+1, index) + nafmsic(j, index))/2;
            
            % moments of inertia
            nIzzmn(j, h) = (nhm*nbm^3)/12;
            nIyymn(j, h) = (nbm*nhm^3)/12;
            
        end
        index = index + 4;
    end
    
    %% Total Composite
    for j=1:1:nj-1
        % calculate total composite area
        TotAn(j) = An(j);
        for h=1:1:numnaf
            TotAn(j) = TotAn(j) - nAmn(j, h);
        end
        
        % calculate centroid of composite rectangles
        Totzbarn(j) = zbarn(j)*An(j);
        Totybarn(j) = ybarn(j)*An(j);
        for h=1:1:numnaf
            Totzbarn(j) = Totzbarn(j) - nzbarmn(j, h)*nAmn(j, h);
            Totybarn(j) = Totybarn(j) - nybarmn(j, h)*nAmn(j, h);
        end
        Totzbarn(j) = Totzbarn(j)/TotAn(j);
        Totybarn(j) = Totybarn(j)/TotAn(j);
        
        % calculate moment of inertia of composite rectangles
        TotIzzn(j) = (Izzn(j) + ((An(j))*abs((ybarn(j)) - Totybarn(j))^2));
        TotIyyn(j) = (Iyyn(j) + ((An(j))*abs((zbarn(j)) - Totzbarn(j))^2));
        for h=1:1:numnaf
            TotIzzn(j) = TotIzzn(j) - (nIzzmn(j, h)...
                + ((nAmn(j, h))*abs((nybarmn(j, h)) - Totybarn(j))^2));
            TotIyyn(j) = TotIyyn(j) - (nIyymn(j, h)...
                + ((nAmn(j, h))*abs((nzbarmn(j, h)) - Totzbarn(j))^2));
        end
    end
    
    %% Calculate af section product and moments of inertia from composite rectangles
    cmoi = compositemoi(TotIzzn, TotIyyn, TotAn, Totzbarn, Totybarn);
    IzzS(k) = cmoi(:, 1);
    IyyS(k) = cmoi(:, 2);
    IyzS(k) = cmoi(:, 3);
    
    %% Transform sectional product and moments of inertia
    IzzSX(k) = (IyyS(k) + IzzS(k))/2 - (IyyS(k) - IzzS(k))/2*cos(2*beta(k, 1))...
        + IyzS(k)*sin(2*beta(k, 1));
    IyySX(k) = (IyyS(k) + IzzS(k))/2 + (IyyS(k) - IzzS(k))/2*cos(2*beta(k, 1))...
        - IyzS(k)*sin(2*beta(k, 1));
    
    IyzSX(k) = (IyyS(k) -  IzzS(k))/2*sin(2*beta(k, 1)) + IyzS(k)*cos(2*beta(k, 1));
    
end
%% Debug

%% Return
asdf = [rR, IzzSX, IyySX, IyzSX, c(:,1), beta(:,1)];