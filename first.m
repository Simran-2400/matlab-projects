load smoke.mat

% Extract variables from the table
profession = smoke.profession;
smoke_frequency = smoke.smoke_frequency;

% Convert to categorical (recommended)
profession = categorical(profession);
smoke_frequency = categorical(smoke_frequency);

% Construct contingency table
[abha, rowLabels, colLabels] = crosstab(profession, smoke_frequency);
