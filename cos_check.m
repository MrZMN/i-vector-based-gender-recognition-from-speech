% load('Ivectors_male_train.mat', 'Ivectors_male_train') %113*19
% load('Ivectors_female_train.mat', 'Ivectors_female_train') %108*19
% load('Ivectors_male_test.mat', 'Ivectors_male_test') %32*19
% load('Ivectors_female_test.mat', 'Ivectors_female_test') %32*19

%% Load Ivectors
load('wholeIvectors', 'wholeIvectors')
Ivectors_male_train = wholeIvectors(1:113,:);       %113*19 male_trainingset
Ivectors_female_train = wholeIvectors(114:221,:);   %108*19 female_trainingset
Ivectors_male_test = wholeIvectors(222:253,:);      %32*19 male_testset
Ivectors_female_test = wholeIvectors(254:285,:);    %32*19 female_testset

%% Calculate mean Ivector of (fe)male training set
% mean of ivectors for male training 
male_train_mean = zeros(200,1);
for i = 1:113
    for j = 19
        male_train_mean = male_train_mean + Ivectors_male_train{i,j};
    end
end
male_train_mean = male_train_mean/(size(Ivectors_male_train,1)*size(Ivectors_male_train,2));

% mean of ivectors for female training 
female_train_mean = zeros(200,1);
for i = 1:108
    for j = 1:19
        female_train_mean = female_train_mean + Ivectors_female_train{i,j};
    end
end
female_train_mean = female_train_mean/(size(Ivectors_female_train,1)*size(Ivectors_female_train,2));

%% Test the accuracy
% test the accuracy of male Ivectors
rightnum=0;
for i = 1:32
    for j = 1:19
        cosmale=dot(Ivectors_male_test{i,j},male_train_mean)/norm(Ivectors_male_test{i,j})/norm(male_train_mean);
        cosfemale=dot(Ivectors_male_test{i,j},female_train_mean)/norm(Ivectors_male_test{i,j})/norm(female_train_mean);
        if cosmale >= cosfemale
            rightnum = rightnum+1;
        end
    end
end
accuracy_male = rightnum/(size(Ivectors_male_test,1)*size(Ivectors_male_test,2))    % 71.71%

% test the accuracy of female Ivectorss
rightnum=0;
for i = 1:32
    for j = 1:19
        cosmale=dot(Ivectors_female_test{i,j},male_train_mean)/norm(Ivectors_female_test{i,j})/norm(male_train_mean);
        cosfemale=dot(Ivectors_female_test{i,j},female_train_mean)/norm(Ivectors_female_test{i,j})/norm(female_train_mean);
        if cosmale <= cosfemale
            rightnum = rightnum+1;
        end
    end
end
accuracy_female = rightnum/(size(Ivectors_female_test,1)*size(Ivectors_female_test,2))  % 78.45%

%%
% Normalization
% for i = 1:113
%     for j = 1:19
%         Ivectors_male_train{i,j} =  mapminmax(Ivectors_male_train{i,j}',-1,1)';
%     end
% end
% for i = 1:108
%     for j = 1:19
%         Ivectors_female_train{i,j} =  mapminmax(Ivectors_female_train{i,j}',-1,1)';
%     end
% end
% for i = 1:32
%     for j = 1: 19
%         Ivectors_male_test{i,j} =  mapminmax(Ivectors_male_test{i,j}',-1,1)';
%     end
% end
% for i = 1:32
%     for j = 1:19
%         Ivectors_female_test{i,j} =  mapminmax(Ivectors_female_test{i,j}',-1,1)';
%     end
% end
