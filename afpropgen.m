% function asdf = afpropgen(af, naf, c, beta, opmode)

%{
    Function: propertygenerator(af, naf, c, beta)

    Purpose: Find section area moments of inertias in Z (flapwise) and Y
    (edgewise) directions AND product of inertia,

    Parameters:
    - af (airfoil geometry)
    - naf (negative geometry)
    - c (chord at each span)
    - beta (twist at each span)
    - opmode (operation mode)

    Returns:
    - IzzSX (flapwise area moment of inertia at radial/spanwise locations)
    - IyySX (edgewise ---------------------- " ----------------------)
    - IyzSX (product of inertia at radial/spanwise locations)

    Notes:
    - function in progress will replace propGenFoil2D.m

    TO DO:
    - implemter afloader into function to support multiple negative
    geometries
    - build in operation modes
        - case: no negative space
    - build in varying negative space per spanwise/radial station
    - pseudo exception handling for invalid negative geometries
%}

%% EASY DEBUGGING; REMOVE BEFORE REVERTING BACK TO FCN
clear; clc;

% af = csvread('Airfoils/circle.csv', 1);
af = csvread('Airfoils/naca2412.csv', 1);
naf = csvread('Airfoils/circle2.csv', 1);
% naf = csvread('Airfoils/zeroline.csv', 1);
c = 1;
beta = 1;
opmode = 0;

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

%% Identify operation mode
switch opmode
    case 0 % self detect mode
    case 1 % simple internal geometry (naf is single airfoil file)
    case 2 % complex internal geometry (naf is dir path or struct)
    case 3 % no negative space
    case 4 % advanced user mode (FUNCTIONALITY TBD)
end

%% Interpolate airfoils
afsi = afinterp(af, 'makima');
nafsi = afinterp(naf, 'makima');

%% Load and process negative space
fp = "Airfoils/Negative0";
nafm = afloader(fp); % create airfoil matrix
nafmsi = afmatinterp(nafm); % separates and interpolates airfoil matrix
numnaf = length(nafm(1,:))/2;

%% Initial variables
% define matrix sizes and loop iterations
nj = 2*length(afsi(:,1)) - 1;
mid = ((nj)/2 + 0.5);
span = max(size(c));

% separate airfoil geometry file into upper and lower surfaces
upper = afsi(:, 1:2);
lower = afsi(:, 3:4);

% separate negative geometry file into up and lower
nupper = nafsi(:, 1:2);
nlower = nafsi(:, 3:4);

%% Test plots
plot(upper(:, 1), upper(:, 2))
hold on
plot(lower(:, 1), lower(:, 2))
index = 1;
for h=1:1:numnaf
    hold on
    plot(nafmsi(:, index), nafmsi(:, index+1))
    hold on
    plot(nafmsi(:, index+2), nafmsi(:, index+3))
    
    index = index + 4;
end
% hold on
% plot(nupper(:, 1), nupper(:, 2))
% hold on
% plot(nlower(:, 1), nlower(:, 2))

% initialize arrays
Izzn = zeros(mid, 1); % moment of inertia for each rectangle
Iyyn = zeros(mid, 1);
% nIzzn = zeros(mid, 1); % moment of inertia of negative space
% nIyyn = zeros(mid, 1);
TotIzzn = zeros(mid, 1); % moment of inertia of composite rectangles
TotIyyn = zeros(mid, 1);

% ********
nIzznm = zeros(mid, numnaf);
nIyynm = zeros(mid, numnaf);

An = zeros(mid-1, 1); % area for each rectangle
% nAn = zeros(mid-1, 1); % area of negative space
TotAn = zeros(mid-1, 1); % total area of composite rectangles

zbarn = zeros(mid-1, 1); % centroid for each rectangle
ybarn = zeros(mid-1, 1);
% nzbarn = zeros(mid-1, 1); % centroid of negative space
% nybarn = zeros(mid-1, 1);
Totzbarn = zeros(mid-1, 1); % centroid of composite rectangles
Totybarn = zeros(mid-1, 1);

IzzS = zeros(span, 1); % total moments of inertia for each airfoil section
IyyS = zeros(span, 1);
IyzS = zeros(span, 1); % product of inertia for each airfoil section

IzzSX = zeros(span, 1); % total moments of inertia for each airfoil section
IyySX = zeros(span, 1);
IyzSX = zeros(span, 1); % product of inertia for each airfoil section

%% Loop through spanwise/radial stations
for k=1:1:span
    
    %% Scale airfoil by chord length
    upperc = upper.*c(k);
    lowerc = lower.*c(k);
    
%     nupperc = nupper.*c(k); % negative space
%     nlowerc = nlower.*c(k);
    
    %% Calculate rectangular moments of inertia and intermediate values
    %% Solid airfoil
    for j=1:1:mid-1
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
    
%     %% Negative space
%     for j=1:1:mid-1
%         % calculate rectangle base and height
%         nb = nupperc(j+1, 1) - nupperc(j, 1);
%         nh = (nupperc(j, 2) - nlowerc(j, 2)...
%             + nupperc(j+1, 2) - nlowerc(j+1, 2))/2;
%         
%         % calculate area of rectangle
%         nAn(j) = nb*nh;
%         
%         % calculate centroid of each individual rectangle
%         nzbarn(j) = (nupperc(j, 2) + nlowerc(j, 2)...
%             + nupperc(j+1, 2) + nlowerc(j+1, 2))/4; % negative space
%         nybarn(j) = (nupperc(j+1, 1) + nupperc(j, 1))/2;
%         
%         % calculate rectangle moments of inertia
%         nIzzn(j) = (nh*nb^3)/12; % negative space
%         nIyyn(j) = (nb*nh^3)/12;
%     end
    
    
    %% Negative space (multiple)
    index = 1;
    for h=1:1:numnaf
        for j=1:1:mid-1
            nbm = nafmsi(j+1, index) - nafmsi(j, index);
            nhm = (nafmsi(j, index+1) - nafmsi(j, index+3)...
                + nafmsi(j+1, index+1) - nafmsi(j+1, index+3))/2;
            nAmn(j, h) = nbm*nhm;
            
            nzbarmn(j, h) = (nafmsi(j, index+1) + nafmsi(j, index+3)...
                + nafmsi(j+1, index+1) + nafmsi(j+1, index+3))/4;
            nybarmn(j, h) = (nafmsi(j+1, index) + nafmsi(j, index))/2;
            
            nIzzmn(j, h) = (nhm*nbm^3)/12;
            nIyymn(j, h) = (nbm*nhm^3)/12;
            
        end
        index = index + 4;
    end
    
    %% Total Composite
    for j=1:1:mid-1
%         zTotAn(j) = An(j) - nAn(j); % ---composite area
        
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
        
        
        % ---calculate centroid of composite rectangles
%         zTotzbarn(j) = (zbarn(j)*An(j) - nzbarn(j)*nAn(j))/zTotAn(j);
%         zTotybarn(j) = (ybarn(j)*An(j) - nybarn(j)*nAn(j))/zTotAn(j);
%         % ---calculate moment of inertia of composite rectangles
%         zTotIzzn(j) = (Izzn(j) + ((An(j))*abs((ybarn(j)) - Totybarn(j))^2))...
%             - (nIzzn(j) + ((nAn(j))*abs((nybarn(j)) - Totybarn(j))^2));
%         zTotIyyn(j) = (Iyyn(j) + ((An(j))*abs((zbarn(j)) - Totzbarn(j))^2))...
%             - (nIyyn(j) + ((nAn(j))*abs((nzbarn(j)) - Totzbarn(j))^2));
        
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
    
    %% Calculate total product and moments of inertia from composite rectangles
    cmoi = compositemoi(TotIzzn, TotIyyn, TotAn, Totzbarn, Totybarn);
    IzzS(k) = cmoi(:, 1);
    IyyS(k) = cmoi(:, 2);
    IyzS(k) = cmoi(:, 3);
    
    %% Transform sectional product and moments of inertia
    IzzSX(k) = (IyyS(k) + IzzS(k))/2 - (IyyS(k) - IzzS(k))/2*cos(2*beta(k))...
        + IyzS(k)*sin(2*beta(k));
    IyySX(k) = (IyyS(k) + IzzS(k))/2 + (IyyS(k) - IzzS(k))/2*cos(2*beta(k))...
        - IyzS(k)*sin(2*beta(k));
    
    IyzSX(k) = (IyyS(k) -  IzzS(k))/2*sin(2*beta(k)) + IyzS(k)*cos(2*beta(k));
    
end
%% Debug
[IzzSX, IyySX, IyzSX]

%% Return
% asdf = [IzzSX, IyySX, IyzSX];