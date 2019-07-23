%% UBM model

speechset = [male_train_set;female_train_set;male_test_set;female_test_set];   %285*19
num_mix = 32;       %num of components        
final_niter = 10;
ds_factor = 1;
nWorkers = 1; 
ubm = gmm_em(speechset(:), num_mix, final_niter, ds_factor, nWorkers);