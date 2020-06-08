function asdf = deflecfxf(x, EI1, EI2, beta, v, py, pz)

%{
    Function: deflecfxf(x, EI1, EI2, beta, v, py, pz)

    Purpose: Find y and z deflections, y and z moments, and y and z
    deflection angles for fixed-free (fxf) boundary conditions

    Parameters: x (distance along blade), EI1, EI2 (y-edgewise and
    z-flapwise blade stiffness),beta (twist), v (pitch), py, pz (y-edgewise
    and z-flapwise loads)

    Returns: y and z deflections and moments, y and z blade deflection
    angles theta

    Notes:
    - EI1 and EI2 are just modulus of elasticity multiplied by area moment
    of inertia --> EI1 = E*Iyy
%}

%% Initial variables
% define loop iterations
nj = max(size(x));

% initialize arrays for vars w/ root BCs
M1=1:nj;
M2=1:nj;
kappa1=1:nj;
kappa2=1:nj;
kappay=1:nj;
kappaz=1:nj;

thetay=1:nj-1;
thetaz=1:nj-1;
uy=1:nj-1;
uz=1:nj-1;

%% Boundary conditions
% fixed-free BC definitions
Ty(nj) = 0.;
Tz(nj) = 0.;

My(nj) = 0.;
Mz(nj) = 0.;

thetay(1) = 0.;
thetaz(1) = 0.;

uy(1) = 0.;
uz(1) = 0.;

%% Iterate to solve for unknowns
for j=nj:-1:2
    Ty(j-1) = Ty(j) + 1/2*(py(j-1) +py(j))*(x(j) -x(j-1));
    Tz(j-1) = Tz(j) + 1/2*(pz(j-1) +pz(j))*(x(j) -x(j-1));
    
    My(j-1) = My(j) - Tz(j)*(x(j) -x(j-1)) - (1/6*pz(j-1) + 1/3*pz(j))*(x(j) -x(j-1)).^2;
    Mz(j-1) = Mz(j) + Ty(j)*(x(j) -x(j-1)) + (1/6*py(j-1) + 1/3*py(j))*(x(j) -x(j-1)).^2;
end


for j=1:1:nj
    M1(j) = My(j)*sin(beta(j) +v(j)) - Mz(j)*cos(beta(j) + v(j));
    M2(j) = My(j)*cos(beta(j) +v(j)) + Mz(j)*sin(beta(j) + v(j));
    
    kappa1(j) = M1(j)/(EI1(j));
    kappa2(j) = M2(j)/(EI2(j));
    
    kappaz(j) = -kappa1(j)*sin(beta(j) +v(j)) + kappa2(j)*cos(beta(j) + v(j));
    kappay(j) = kappa1(j)*cos(beta(j) +v(j)) + kappa2(j)*sin(beta(j) + v(j));
end

for j=1:1:nj-1
    thetay(j+1) = thetay(j) + 1/2*(kappay(j+1) + kappay(j))*(x(j+1) - x(j));
    thetaz(j+1) = thetaz(j) + 1/2*(kappaz(j+1) + kappaz(j))*(x(j+1) - x(j));
    
    uy(j+1) = uy(j) + thetaz(j)*(x(j+1) - x(j)) + (1/6*kappaz(j+1)...
        + 1/3*kappaz(j))*(x(j+1) - x(j)).^2;
    uz(j+1) = uz(j) - thetay(j)*(x(j+1) - x(j)) + (1/6*kappay(j+1)...
        + 1/3*kappay(j))*(x(j+1) - x(j)).^2;
end

%% Return
asdf = [uy', uz', My', Mz', thetay', thetaz'];