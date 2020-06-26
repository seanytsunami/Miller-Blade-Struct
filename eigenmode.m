function asdf = eigenmode(x, EI1, EI2, beta, v, mass)

%{
    Function: eigenmode(x, EI1, EI2, beta, v, mass)

    Purpose: Find mode frequencies, eigenmodes, and eigenvectors

    Parameters: x (distance along blade), EI1, EI2 (y and z blade
    stiffness), beta (twist), v (pitch), and m (sectional mass)

    Returns: omegas (mode frequencies), eigmodes (eigenmodes), eigvals
    (eigenvalues)

    Notes:
    - EI1 and EI2 are just modulus of elasticity multiplied by area moment
    of inertia --> EI1 = E*Iyy
    - Heavy port of original Miller code

    TO DO: clean up for consistency
%}

%% Initial variables
% define loop iterations
nj = max(size(x));

% initialize arrays
py = zeros(nj,1);
pz = zeros(nj,1);

flexm = zeros(2*nj-2,2*nj-2);
massm = flexm;

%% Calculation of eigenvectors and eigenmodes
% flexibility matrix, y loading
for j = 2:1:nj
    m = 2*j-3;
    py(j) = 1.0;
    pz(j) = 0.0;
    flexy = deflecfxf(x,EI1,EI2,beta,v,py,pz);
    py(j) = 0.0;
    pz(j) = 0.0;
    
    % load flex. matrix
    for k = 2:1:nj
        n = 2*k-3;
        flexm(n,m) = flexy(k, 1);
        flexm(n+1,m) = flexy(k, 2);
    end
end

% flexibility matrix, z loading
for j=2:1:nj
    m = 2*j-2;
    py(j) = 0.0;
    pz(j) = 1.0;
    flexz = deflecfxf(x,EI1,EI2,beta,v,py,pz);
    py(j) = 0.0;
    pz(j) = 0.0;
    
    % load flex. matrix
    for k = 2:1:nj
        n = 2*k-3;
        flexm(n,m) = flexz(k, 1);
        flexm(n+1,m) = flexz(k, 2);
    end
end

%% Mass matrix
for j=2:1:nj
    n = 2*j-3;
    massm(n,n) = mass(j);
    massm(n+1,n+1) = mass(j);
end

[V,D] = eigs(flexm*massm,nj);

%% Eigenvalues and eigenvectors
omegas = sqrt(1./(D*ones(nj,1)));
uyev = zeros(nj,nj);
uzev = uyev;

for j=2:1:nj
    n = 2*j-3;
    uyev(j,1:nj) = -V(n,1:nj);
    uzev(j,1:nj) = -V(n+1,1:nj);
end

%% Debug

V;
D;
D*ones(nj,1);
flexm;
massm;
omegas;
uyev;
uzev;

%% Return
asdf = [omegas, uyev, uzev]; % returns [nj x 1, nj x nj, nj x nj]
