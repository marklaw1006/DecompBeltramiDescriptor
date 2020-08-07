mu_file = 'data/mu_files/synthetic_example/test/mu.mat';
mu_gt_file = 'data/mu_files/synthetic_example/gt/mu.mat';
output_file = 'output/synthetic_example/';
ref_image_name = '0.png';
image_file = 'data/pics/synthetic_example/test/';
experiment_name = 'synthetic';

folder_name = 'example_param/';
file_name = 'synthetic_example.mat';
file_name = strcat(folder_name, file_name);
save(file_name, 'mu_file','mu_gt_file','output_file','ref_image_name','image_file','experiment_name');


mu_file = 'data/mu_files/first_heart_example/test/mu.mat';
mu_gt_file = 'data/mu_files/first_heart_example/gt/mu.mat';
output_file = 'output/first_heart_example/';
ref_image_name = '1.png';
image_file = 'data/pics/first_heart_example/test/';
experiment_name = 'first heart example';

folder_name = 'example_param/';
file_name = 'first_heart_example.mat';
file_name = strcat(folder_name, file_name);
save(file_name, 'mu_file','mu_gt_file','output_file','ref_image_name','image_file','experiment_name');


mu_file = 'data/mu_files/second_heart_example/test/mu.mat';
mu_gt_file = 'data/mu_files/second_heart_example/gt/mu.mat';
output_file = 'output/second_heart_example/';
ref_image_name = '4.png';
image_file = 'data/pics/second_heart_example/test/';
experiment_name = 'second_heart';

folder_name = 'example_param/';
file_name = 'second_heart_example.mat';
file_name = strcat(folder_name, file_name);
save(file_name, 'mu_file','mu_gt_file','output_file','ref_image_name','image_file','experiment_name');


mu_file = 'data/mu_files/first_lung_example/test/mu.mat';
mu_gt_file = 'data/mu_files/first_lung_example/gt/mu.mat';
output_file = 'output/first_lung_example/';
ref_image_name = '1.png';
image_file = 'data/pics/first_lung_example/test/';
experiment_name = 'first_lung';

folder_name = 'example_param/';
file_name = 'first_lung_example.mat';
file_name = strcat(folder_name, file_name);
save(file_name, 'mu_file','mu_gt_file','output_file','ref_image_name','image_file','experiment_name');

mu_file = 'data/mu_files/second_lung_example/test/mu.mat';
mu_gt_file = 'data/mu_files/second_lung_example/gt/mu.mat';
output_file = 'output/second_lung_example/';
ref_image_name = '4.png';
image_file = 'data/pics/second_lung_example/test/';
experiment_name = 'second_lung';

folder_name = 'example_param/';
file_name = 'second_lung_example.mat';
file_name = strcat(folder_name, file_name);
save(file_name, 'mu_file','mu_gt_file','output_file','ref_image_name','image_file','experiment_name');
