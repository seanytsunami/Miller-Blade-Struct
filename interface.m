classdef interface
    %{
    Class: interface

    Purpose: Couples the GUI with all the function libraries associated
    with Miller-Blade-Struct

    Notes:
    %}
    
    properties
    end
    
    % Interface Functions
    methods(Static)
        % simplepropgen
        function prop = simplepropgen(af, c, beta)
            addpath('property-generator/');
            header = ["r/R", "Izz[m^4]", "Iyy[m^4]", "Iyz[m^4]",...
                "Area[m^2]", "Chord[m]", "Twist[Rad]"];
            prop = [header; simplepropgen(af, c, beta)];
        end
        % afpropgen
        function prop = afpropgen(af, naf, c, beta)
            addpath('property-generator/');
            header = ["r/R", "Izz[m^4]", "Iyy[m^4]", "Iyz[m^4]",...
                "Area[m^2]", "Chord[m]", "Twist[Rad]"];
            prop = [header; afpropgen(af, naf, c, beta)];
        end
        % xturbreader
        function xturbout = xturbreader(filePath)
            addpath('xturb-backend/');
            xturbout = xturbreader(filePath);
        end
        % xturbloads
        function xturbl = xturbloads(dirPath)
            addpath('xturb-backend/');
            header = ["r/R", "Fz[N]", "Fy[N]", "rho[kg/m^3]",...
                "Vrel[m/s]", "Bradius[m]"];
            xturbl = [header; xturbloads(dirPath)];
        end
        % bladestructgen
        function blades = bladestructgen(bladeprop, EE, m, pitch)
            addpath('blade-struct/');
            header = ["x", "EI1", "EI2", "Pitch[rad]",...
                "Twist[rad]", "Mass[kg]"];
            blades = [header; bladestructgen(bladeprop, EE, m, pitch)];
        end
        % bladestructgenusermat
        function blades = bladestructgenusermat(bladeprop, EE, m, pitch)
            addpath('blade-struct/');
            header = ["x", "EI1", "EI2", "Pitch[rad]",...
                "Twist[rad]", "Mass[kg]"];
            bladepropt = table2array(readtable(bladeprop));
            
            % load values from material prop
            EE = double(string(EE));
            m = double(string(m));
            EE2 = [bladepropt(:,1), ones(length(bladepropt(:,1)), 1).*EE,...
                ones(length(bladepropt(:,1)), 1).*EE];
            m2 = ones(length(bladepropt(:,1)),2);
            
            for j=1:1:length(bladepropt(:,1))
                m2(j, 1) = bladepropt(j,1);
                if length(bladepropt(:,1)) == 1
%                     m2(j, 2) = NaN;
                    m2(j, 2) = bladepropt(j, 5)*m;
                elseif j == 1
                    dA = (bladepropt(j, 5) + bladepropt(j+1, 5))/2;
                    dx = (bladepropt(j+1, 1) - bladepropt(j, 1));
                    m2(j, 2) = dA*dx*m;
                else
                    dA = (bladepropt(j, 5) + bladepropt(j-1, 5))/2;
                    dx = (bladepropt(j, 1) - bladepropt(j-1, 1));
                    m2(j, 2) = dA*dx*m;
                end
            end
            blades = [header; bladestructgen(bladeprop, EE2, m2, pitch)];
        end
        % deflecfxf
        function deflec = deflecfxf(bladestruct, xturbl)
            addpath('blade-struct/');
            bs = table2array(readtable(bladestruct));
            xtl = table2array(readtable(xturbl));
            
            header = ["uy[m]", "uz[m]", "My[Nm]",...
                "Mz[Nm]", "Thetay[rad]", "Thetaz[rad]"];
            deflec = [header;...
                deflecfxf(bs(:,1), bs(:,2), bs(:,3), bs(:,5), bs(:,4),...
                xtl(:,3), xtl(:,2))];
        end
        % eigenmode
        function eigm = eigenmode(bladestruct)
            addpath('blade-struct/');
            bs = table2array(readtable(bladestruct));
            
            eigm =  eigenmode(bs(:,1), bs(:,2), bs(:,3), bs(:,5),...
                bs(:,4), bs(:,6));
        end
    end
    
    % Debugging Function(s)
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
            
            
            %             eigm = interface.eigenmode(...
            %                 "output/Blade-Struct_EAl6061_circle_Complex_twist0to0_chord1to2.csv")
            %             xtl = interface.xturbloads(xtout)
            %             pspg = interface.simplepropgen(rect, chord11, twist00)
            %             papg = interface.afpropgen(circle, zl, 1, 0)
            %             t = interface.xturbreader("sample-files/xturb1/XTurb_Output1.dat");
        end
    end
end