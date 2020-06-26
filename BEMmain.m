%{
    Function: BEMmain

    Purpose: The purpose of the main function is to validate the working order
    of the BEM code via function calls and plots

    Written by: Sean Wang
%}

clear; clc;

%% Blade Properties
% Hansen Blade Properties (imported from csv)
bladeProp = csvread('Airfoils/hansenBladeProp.csv', 1);
x = bladeProp(:,1);
EI1 = bladeProp(:,3);
EI2 = bladeProp(:,4);
beta = bladeProp(:,11) - bladeProp(:,10);
v = bladeProp(:,10);
% m = bladeProp(:,6).*bladeProp(:,1);

m = ones(12); % arbitrary mass values
py = ones(12); % arbitrary load values
pz = ones(12);

%% Straight beam reference case
% xlength = 11;
% x = linspace(0, 1, xlength);
% EI1 = ones(xlength);
% EI2 = ones(xlength);
% beta = zeros(xlength);
% v = zeros(xlength);
% m = ones(xlength);
% py = zeros(xlength);
% pz = ones(xlength);

%% Sample file paths
g0 = "XTurb/2to25/XTurb_Output.dat";
g1 = "XTurb/2to25/XTurb_Output1.dat";
f0 = "XTurb/cd0jx31/XTurb_Output.dat";
f1 = "XTurb/cd0jx31/XTurb_Output1.dat";
f2 = "XTurb/cd0jx31/XTurb_Output2.dat";
f3 = "XTurb/cd0jx31/XTurb_Output3.dat";

%% NACA 2412 reference case
ndc = csvread('Airfoils/naca2412.csv', 1);

%% Shitty Rectangle
r = csvread('Airfoils/rectangle.csv', 1);

%% Zero line
zl = csvread('Airfoils/zeroline.csv', 1);

%% I-Beam
IB = csvread('Airfoils/IBeam.csv', 1);

%% Oval
oval = csvread('Airfoils/Oval.csv', 1);
circle = table2array(readtable("Airfoils/circle.csv"));
circle2 = table2array(readtable("Airfoils/circle2.csv"));

%% Generic chord and twist distributions
cdistr = ones(10, 1);
% twistdistr = zeros(10, 1);

% cdistr = linspace(1, 2, 10);
twistdistr = linspace(0, pi, 10);

%% Function calls
asdf = deflecfxf(x, EI1, EI2, beta, v, py, pz); % call deflec function
jkl = eigenmode(x, EI1, EI2, beta, v, m); % call eigenmode function

ndci = afinterp(ndc, 'makima'); % airfoil interpolator

% NACA2412Prop = propGenFoil(ndc, 1, 0) % property generator
% NACA2412Prop2 = propGenFoil2D(ndc, ndc2, 1, 0)
% NACA2412Prop21 = propGenFoil2D(ndc, ndc3, 1, 0)
% NACA2412Prop22 = afpropgen(ndc, ndc3, 1, 0, 0)

RectProp = propGenFoil(r, 1, 0);
rp2 = afpropgen(r, zl, 1, 0, 0)
rectangleIzzIyy = ([0.04 * 1^3 / 12, 0.04^3 * 1 / 12]);

% circlep = propGenFoil(circle, 1, 0)
% circlep2 = afpropgen(circle, R2, 1, 0, 0)
% donut = afpropgen(circle, circle2, 1, 0, 0)


IBeamProp = propGenFoil(IB, 1, 0);

OvalProp = propGenFoil(oval, 1, 0);
OvalIzzIyy = ([pi/4*0.5^3*0.25, pi/4*0.5*0.25^3]);

sep = foilSep(ndc); % airfoil separator

% xturbreader(f1) % xturb reader

%% Prints

%% Plotting
%% Separated Airfoil
% plot(sep(:,1), sep(:,2))
% hold on
% plot(sep(:,3), sep(:,4))
% axis([0, 1, -0.3, 0.3])
% title('NACA 2412');
% xlabel('$\frac{x}{c}$', 'Interpreter', 'latex');
% ylabel('y');
% legend('upper', 'lower')

%% Y eigenmodes
% figure('name', 'flapwise z')
% for j=2:1:13
%     md = mod(j,2);
%     if md == 0
%         plot(x, jkl(:,j))
%         hold on
% 
%     end
%     for n=1:6
%         leg{n}=sprintf('mode%d',n);
%     end
% end
% legend(leg);
% 
% figure('name', 'flapwise y')
% for j=2:1:13
%     md = mod(j,2);
%     if md == 1
%         plot(x, jkl(:,j))
%         hold on
% 
%     end
%     for n=1:6
%         leg{n}=sprintf('mode%d',n);
%     end
% end
% legend(leg);

%% Z eigenmodes
% figure('name', 'edgewise z')
% for j=14:1:25
%     md = mod(j,2);
%     if md == 0
%         plot(x, jkl(:,j))
%         hold on
%
%     end
%     for n=1:6
%         leg{n}=sprintf('mode%d',n);
%     end
% end
% legend(leg);
%
% figure('name', 'edgewise y')
% for j=14:1:25
%     md = mod(j,2);
%     if md == 1
%         plot(x, jkl(:,j))
%         hold on
%
%     end
%     for n=1:4
%         leg{n}=sprintf('mode%d',n);
%     end
% end
% legend(leg);

%% First eigeinmodes (?)
% for j=1:1
%     figure('name', 'first eigenmodes')
%     plot(x, jkl(:,2))
%     hold on
%     plot(x, jkl(:,3))
%     hold on
%     plot(x, jkl(:,14))
%     hold on
%     plot(x, jkl(:,15))
%     hold on
% end
% legend('flapwise z', 'flapwise y', 'edgewise z', 'edgewise y');

%% Second eigenmodes (?)
% for j=1:1
%     figure('name', 'second eigenmodes')
%     plot(x, jkl(:,4))
%     hold on
%     plot(x, jkl(:,5))
%     hold on
%     plot(x, jkl(:,16))
%     hold on
%     plot(x, jkl(:,17))
%     hold on
% end
% legend('flapwise z', 'flapwise y', 'edgewise z', 'edgewise y');

%% NACA 2412 chord distribution
% plot(ndc(:, 1), ndc(:, 2))
% hold on
% plot(ndc2(:, 1), ndc2(:, 2))
% ylim([-0.3, 0.3]);
% hold off

%% Shitty rectangle
% plot(sR(:,1), sR(:,2), 'b')
% axis([-0.1 1.1 -0.025 0.025])

%% Oval
% plot(oval(:,1), oval(:,2), 'b')
% axis([0, 1, -0.5, 0.5])
