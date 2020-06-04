function asdf = eigenmode(x, EI1, EI2, beta, v, mass)

%{
  Function: eigenmode(x, EI1, EI2, beta, v, mass)
  
  Purpose: Find mode frequencies, eigenmodes, and eigenvectors
  
  Parameters: x (distance along blade), EI1, EI2 (y and z blade stiffness),
  beta (twist), v (pitch), and m (sectional mass)
  
  Returns: omegas (mode frequencies), eigmodes (eigenmodes), eigvals
  (eigenvalues)
  
  Notes:
  - EI1 and EI2 are just modulus of elasticity multiplied by second area
  moment of inerta --> EI1 = E*Iyy
  - Heavy port of original code
%}

%% Initial Variables
% define loop iterations
nj = max(size(x));

% initialize arrays
py = zeros(nj,1);
pz = zeros(nj,1);

flexm = zeros(2*nj-2,2*nj-2);
massm = flexm;

%% Calculation of eigvectors and eigmodes
% flexibility matrix, y loading
for j = 2:nj
    m = 2*j-3;
    py(j) = 1.0;
    pz(j) = 0.0;
    %[uy,uz,~,~,~,~]=deflecfxf(x,EI1,EI2,beta,v,py,pz);
    flexy = deflecfxf(x,EI1,EI2,beta,v,py,pz);
    py(j)=0.0;
    pz(j)=0.0;
    for j = 2:nj %Save into flex. matrix
        n = 2*j-3;
        %flexm(n,m) = uy(j);
        %flexm(n+1,m) = uz(j);
        flexm(n,m) = flexy(j, 1);
        flexm(n+1,m) = flexy(j, 2);
    end
end

% flexibility matrix, z loading
for j = 2:nj
    m = 2*j-2;
    py(j) = 0.0;
    pz(j) = 1.0;
    %[uy,uz,~,~,~,~]=deflecfxf(x,EI1,EI2,beta,v,py,pz);
    flexz = deflecfxf(x,EI1,EI2,beta,v,py,pz);
    py(j)=0.0;
    pz(j)=0.0;
    for j = 2:nj %Save into flex. matrix
        n = 2*j-3;
        %flexm(n,m) = uy(j);
        %flexm(n+1,m) = uz(j);
        flexm(n,m) = flexz(j, 1);
        flexm(n+1,m) = flexz(j, 2);
    end
end

% Mass Matrix %
for j = 2:nj
    n = 2*j-3;
    massm(n,n) = mass(j);
    massm(n+1,n+1) = mass(j);
end

[V,D] = eigs(flexm*massm,nj);

%Evalues/Evectors%
omegas = sqrt(1./(D*ones(nj,1)));
uyev = zeros(nj,nj);
uzev = uyev;

for j=2:nj
    n=2*j-3;
    uyev(j,1:nj)=-V(n,1:nj);
    uzev(j,1:nj)=-V(n+1,1:nj);
end

omegas;
uyev;
uzev;

asdf = [omegas, uyev, uzev];
