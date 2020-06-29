function asdf = xturbloads(dirPath)

%{
    Function: xturbloads(dirPath)

    Purpose: Loads .csv xturb files from a file directory (must contain
    XTurb_Output.dat and XTurb_Output1.dat to work) and extracts the normal
    and tangential loads 

    Parameters:
    - dirPath (string specifying path of directory)

    Returns:
    - ndc (non-dimensionalized chord)
    - pnormal (normal force acting on blade)
    - ptangen (normal force acting on blade)

    Dependencies:

    Notes:
    - The returns are total forces at the spanwise/radial stations not
    typical loads (force/length or force/area). This is up for change

    TO DO:
%}

%% Load .csv xturb files (created with xturbreader)
csvfiles = dir(strcat(dirPath, "/*.csv"));
cfiles = struct2cell(csvfiles);

% extract file paths from cfiles
fpfiles = strcat(string(cfiles(2, :)), "/", string(cfiles(1, :)));
fpfiles = erase(fpfiles, strcat(pwd, "/"));

%% Convert relevant .csv files to matrix
for j=1:1:length(fpfiles)
    if contains(fpfiles(j), "Output1.csv")
        out1 = csvread(fpfiles(j), 1);
    end
    if contains(fpfiles(j), "Output2.csv")
        out2 = csvread(fpfiles(j), 1);
    end
end

%% Extract relevant variables
diskarea = pi.*out1(:, 1).^2;
rho = out1(:, 2);
vrel = out2(:, 1);
ndc = out2(:, 10);
cnormal = out2(:, 20);
ctangen = out2(:, 21);

%% Calculate loads (normal - flapwise, tangential - edgewise)
pnormal = cnormal.*0.5.*rho.*(vrel).^2.*diskarea;
ptangen = ctangen.*0.5.*rho.*(vrel).^2.*diskarea;

asdf = [ndc, pnormal, ndc, ptangen];