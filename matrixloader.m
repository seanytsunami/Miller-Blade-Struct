function asdf = matrixloader(tlines, datalog, nvars)

%% Initial variables
% convert tlines to strlines if necessary
strlines = string(tlines);

% initialize counter
counter = 0;

% create empty matrix for data
dlines = zeros(sum(datalog), nvars);

%% Scan through strlines and load doubles into dedicated matrix 
for j=1:1:length(strlines(:,1))
    if datalog(j)
        counter = counter + 1;
        dlines(counter, :) = str2double(regexp(strlines(j),'\d*\.\d*','match')');
    end
end

%% Return
asdf = dlines; % size [length(strlines(:,1)), nvars]