classdef interface
    %{
    
    
    %}
    
    properties
    end
    
    % Interface Functions
    methods(Static)
        function prop = simplepropgen(af, c, beta)
            addpath('property-generator/');
            header = ["r/R", "Izz[m^4]", "Iyy[m^4]", "Iyz[m^4]",...
                "Area[m^2]", "Chord[m]", "Twist[Rad]"];
            prop = [header; simplepropgen(af, c, beta)];
        end
        function prop = afpropgen(af, naf, c, beta)
            addpath('property-generator/');
            header = ["r/R", "Izz[m^4]", "Iyy[m^4]", "Iyz[m^4]",...
                "Area[m^2]", "Chord[m]", "Twist[Rad]"];
            prop = [header; afpropgen(af, naf, c, beta)];
        end
        function xturbout = xturbreader(filePath)
            addpath('xturb-backend/');
            xturbout = xturbreader(filePath);
        end
        function xturbl = xturbloads(dirPath)
            addpath('xturb-backend/');
            header = ["r/R", "Fz[N]", "Fy[N]", "rho[kg/m^3]",...
                "Vrel[m/s]", "Bradius[m]"];
            xturbl = [header; xturbloads(dirPath)];
        end
    end
    
    % Debugging Functions
    methods(Static)
        function debug()
            clear; clc;
            addpath('property-generator/');
            
            naca2412 = "sample-files/airfoils/naca2412.csv";
            zl = "sample-files/airfoils/zeroline.csv";
            circle = "sample-files/shapes/circle.csv";
            circle2 = "sample-files/shapes/circle2.csv";
            rect = "sample-files/shapes/rectangle.csv";
            
            chord11 = "sample-files/radial-prop/chord1to1.csv";
            twist00 = "sample-files/radial-prop/twist0to0.csv";
            twist0PI = "sample-files/radial-prop/twist0toPI.csv";
            
            semicircles = "sample-files/negatives/semicircles/";
            xtout = "output";
            
%             xtl = interface.xturbloads(xtout)
%             pspg = interface.simplepropgen(rect, chord11, twist00)
            papg = interface.afpropgen(circle, zl, 1, 0)
%             t = interface.xturbreader("sample-files/xturb1/XTurb_Output1.dat");
        end
    end
end