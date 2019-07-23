
%% UBM model
load('ubm.mat', 'ubm');  %32 components

%% MFCC Dataset
load('wholespeechset.mat','speechset');  %285*19
num_people = size(speechset,1);
num_speechperpeople = size(speechset,2);

%% Calculate the B-W statistics needed for the iVector model
gmm_models = cell(num_people,num_speechperpeople);
for people=1:num_people
    for speech=1:num_speechperpeople
        [N,F] = compute_bw_stats(speechset{people,speech}, ubm);
        gmm_models{people,speech} = [N; F];
    end
end

%% Learn the total variability subspace/T matrix
tvDim = 200;         %length of I-vector
niter = 10;
nWorkers = 1;
T = train_tv_space(gmm_models(:), ubm, tvDim, niter, nWorkers);

%% Compute the I-vectors
Ivectors = cell(num_people, num_speechperpeople);
for people=1:num_people
    for speech=1:num_speechperpeople
        Ivectors{people,speech} = extract_ivector(gmm_models{people, speech}, ubm, T);   
    end
end
%%
% end

