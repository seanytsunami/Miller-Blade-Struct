classdef interface
    %{
    Class: interface

    Purpose: Couples the GUI with all the function associated with
    Miller-Blade-Struct

    Notes:
    %}
    
    properties
    end
    
    % Interface Functions
    methods(Static)
        % simplepropgen
        function prop = simplepropgen(af, c, beta)
            addpath(genpath('.'));
            prop = simplepropgen(af, c, beta);
        end
        % afpropgen
        function prop = afpropgen(af, naf, c, beta)
            addpath(genpath('.'));
            prop = afpropgen(af, naf, c, beta);
        end
        % xturbreader
        function xturbout = xturbreader(filePath)
            addpath(genpath('.'));
            xturbout = xturbreader(filePath);
        end
        % xturbloads
        function xturbl = xturbloads(dirPath)
            addpath(genpath('.'));
            header = ["r/R", "Fz[N]", "Fy[N]", "rho[kg/m^3]",...
                "Vrel[m/s]", "Bradius[m]"];
            xturbl = [header; xturbloads(dirPath)];
        end
        % bladestructgen
        function blades = bladestructgen(bladeprop, EE, m, pitch)
            addpath(genpath('.'));
            header = ["x", "EI1", "EI2", "Pitch[rad]",...
                "Twist[rad]", "Mass[kg]"];
            blades = [header; bladestructgen(bladeprop, EE, m, pitch)];
        end
        % bladestructgenusermat
        function blades = bladestructgenusermat(bladeprop, EE, m, pitch)
            addpath(genpath('.'));
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
            addpath(genpath('.'));
            bs = table2array(readtable(bladestruct));
            xtl = table2array(readtable(xturbl));
            
            deflec =  deflecfxf(bs(:,1), bs(:,2), bs(:,3), bs(:,5),...
                bs(:,4),xtl(:,3), xtl(:,2));
        end
        % eigenmode
        function eigm = eigenmode(bladestruct)
            addpath(genpath('.'));
            bs = table2array(readtable(bladestruct));
            
            eigm =  eigenmode(bs(:,1), bs(:,2), bs(:,3), bs(:,5),...
                bs(:,4), bs(:,6));
        end
        function inpout = xturbinp(f)
            addpath(genpath('.'));
            inpout = xturbinp(f);t
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
            
            inp = "sample-files/xturb1/NREL_VI.inp";
            
%             xtinp = interface.xturbinp(inp)
%             eigm = interface.eigenmode(...
%                 "output/Blade-Struct_EAl6061_circle_Complex_twist0to0_chord1to2.csv")
%             xtl = interface.xturbloads(xtout)
%             pspg = interface.simplepropgen(rect, chord11, twist00)
%             papg = interface.afpropgen(circle, zl, 1, 0)
%             t = interface.xturbreader("sample-files/xturb1/XTurb_Output1.dat");
        end
        function out = validatedeflec()
            clear; clc;
            addpath(genpath("."));
            k = 0.1; % multiplication factor
            
            nj = [5, 10, 20, 50, 100, 1000];
            
            for j=1:1:length(nj(1, :))
                x = linspace(0, 1, nj(j))';
%                 EI1 = ones(nj(j), 1)*0.048907;
%                 EI1 = ones(nj(j), 1)*0.049067;
                EI1 = ones(nj(j), 1)*1/4*pi*0.5^4;
                EI2 = EI1;
                beta = zeros(nj(j), 1);
                v = beta;
                py = v;
                pz = ones(nj(j),1);
                
                out = deflecfxf(x, EI1, EI2, beta, v, py, pz);
                s{j} = double(out(2:end, :));
            end
            
            % plot
%             figure('name', 'deflecfxf');
%             width=1400;
%             height=250;
%             set(gcf,'position',[100, 100, width, height]);
            
            % deflections
%             for j=1:1:4
%                 c = j+1;
%                 t = linspace(0, 1, nj(c));
%                 d = -1.*t.^2.*(6-4.*t+t.^4)./24./(1/4*pi*0.5^4);
% 
%                 subplot(1,4,j)
%                 plot(t, d, 'k')
%                 hold on
%                 plot(s{c}(:, 1), s{c}(:, 3), 'b');
%                 ylabel('deflection [m]');
%                 yyaxis right
%                 plot(t,100*abs((d' - s{c}(:, 3))./d'), 'color', '#eba534');
%                 title(strcat("n=", string(nj(c))));
%                 legend({'Analytical', 'deflecfxf', 'Abs. % Error'},...
%                     'location', 'west');
%                 ylabel('Abs. error [%]');
%                 xlabel('r [m]');
%             end

            % moments
%             for j=1:1:4
%                 c = j+1;
%                 t = linspace(0, 1, nj(c));
%                 d = -1*((1-t).^2)./2;
%                 
%                 subplot(1,4,j)
%                 plot(t, d, 'linewidth', 0.75, 'color', 'black')
%                 hold on
%                 plot(s{c}(:, 1), s{c}(:, 5), 'bo');
%                 ylabel('M [Nm]');
%                 yyaxis right
%                 plot(t,100*abs(d' - s{c}(:, 5))./d',...
%                     'color', '#eba534');
%                 title(strcat("n=", string(nj(c))));
%                 legend({'Analytical', 'deflecfxf', 'Abs. % Error'},...
%                     'location', 'west');
%                 ylabel('Abs. error [%]');
%                 xlabel('r [m]');
%             end
            
%             out = s;
            
            for j=1:1:max(size(s))
                k(j) = s{j}(end,7);
            end
            out = k';
        end
    end
end