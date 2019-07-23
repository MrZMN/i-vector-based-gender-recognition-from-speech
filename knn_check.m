
%% Load Ivectors
load('wholeIvectors', 'wholeIvectors')
Ivectors_male_train = wholeIvectors(1:113,:);       %113*19 male_trainingset
Ivectors_female_train = wholeIvectors(114:221,:);   %108*19 female_trainingset
Ivectors_male_test = wholeIvectors(222:253,:);      %32*19 male_testset
Ivectors_female_test = wholeIvectors(254:285,:);    %32*19 female_testset

%% Settings
k = 10; 
num_trainingdata = (size(Ivectors_male_train,1) + size(Ivectors_female_train,1))*19;    %4199
num_male_train = size(Ivectors_male_train,1)*19;                                        %2147
num_female_train = size(Ivectors_female_train,1)*19;                                    %2052
%% Male testset accuracy

rightnum = 0;
for i = 1:32
    for j = 1:19
    % for each male test ivector      
        ivec = Ivectors_male_test{i,j};
        
        cosdis_mat = zeros(num_trainingdata,2);  %4199*2
        for z = 1:num_male_train
           cosdis_mat(z,2) = 1;     
        end
        
        flag = 1;
        %cos distances with male training set
        for x = 1:113
            for y = 1:19                
                cosval = dot(ivec,Ivectors_male_train{x,y})/norm(ivec)/norm(Ivectors_male_train{x,y});
                cosdis_mat(flag,1) = cosval; 
                flag = flag+1;
            end
        end
        %cos distances with female training set
        for x = 1:108
            for y = 1:19
                cosval = dot(ivec,Ivectors_female_train{x,y})/norm(ivec)/norm(Ivectors_female_train{x,y});
                cosdis_mat(flag,1) = cosval;
                flag = flag+1;
            end
        end
       
        [rank,ind] = sort(cosdis_mat(:,1));             %sort the cos distances, return the indexes
        if sum(cosdis_mat(ind(4199-k:4199),2))>=k/2     %k=100
            rightnum = rightnum+1;
        end
        
    end
end

accuracy_male = rightnum/(size(Ivectors_male_test,1)*size(Ivectors_male_test,2))

%% Female testset accuracy
rightnum = 0;
for i = 1:32
    for j = 1:19
    % for each female test ivector      
        ivec = Ivectors_female_test{i,j};
        
        cosdis_mat = zeros(num_trainingdata,2);  %4199*2
        for z = 1:num_female_train
           cosdis_mat(z,2) = 1;     
        end
       
        flag = 1;
        %cos distances with female training set
        for x = 1:108
            for y = 1:19
                cosval = dot(ivec,Ivectors_female_train{x,y})/norm(ivec)/norm(Ivectors_female_train{x,y});
                cosdis_mat(flag,1) = cosval;
                flag = flag+1;
            end
        end
        %cos distances with male training set
        for x = 1:113
            for y = 1:19                
                cosval = dot(ivec,Ivectors_male_train{x,y})/norm(ivec)/norm(Ivectors_male_train{x,y});
                cosdis_mat(flag,1) = cosval; 
                flag = flag+1;
            end
        end
        
        [rank,ind] = sort(cosdis_mat(:,1));             %sort the cos distances, return the indexes
        if sum(cosdis_mat(ind(4199-k:4199),2))>=k/2     %k=100
            rightnum = rightnum+1;
        end
        
    end
end

accuracy_female = rightnum/(size(Ivectors_female_test,1)*size(Ivectors_female_test,2))