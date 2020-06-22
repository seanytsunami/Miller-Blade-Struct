function asdf = matrixformatter(lines, dlines, rstations)

flines = ones(length(dlines(:, 1)), length(lines(1, :)));
for j=1:1:length(dlines(:, 1))
    if rem(j, rstations) == 0
        flines(j,:) = lines(j/rstations, :);
    else
        flines(j,:) = lines((fix(j/rstations) + 1), :);
    end
end

%% Returns
asdf = flines;