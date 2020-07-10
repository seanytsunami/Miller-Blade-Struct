function asdf = bladestructgen(bladeprop, EE, m, pitch)

%{
    Function: bladestructgen(bladeprop, EE, m, pitch)

    Purpose: Create a usable matrix by combining input matrices

    Parameters: 
    - bladeprop (file path to file containing blade properties, created by
    the property generator in miller-blade-struct)
    - EE (Young's modulus data in flapwise and edgewise directions)
    - m (sectional mass)
    - pitch (sectional pitch)

    Returns: 
    - x (distance along blade)
    - EI1 (edgewise blade stiffness)
    - EI2 (flapwise blade stiffness)
    - v (sectional pitch)
    - beta (sectional twist)
    - mass (sectional mass)

    Dependencies:
    - getafdat.m

    Notes:

    TO DO:
%}

%% Import matrices from inputs
bladeprop = table2array(readtable(bladeprop));
pitch = getafdata(pitch);
if isstring(EE) || ischar(EE)
    EE = getafdata(EE);
end
if isstring(m) || ischar(m)
    m = getafdata(m);
end

%% Extracts important values from inputs
EI1 = bladeprop(:,3).*EE(:,3);
EI2 = bladeprop(:,2).*EE(:,2);
beta = bladeprop(:,7);
v = pitch(:, 2);
mass = m(:, 2);
x = bladeprop(:, 1);

%% Return
asdf = [x, EI1, EI2, v, beta, mass];