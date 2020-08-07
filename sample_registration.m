function sample_registration(input_folder_path, number_of_frames, output_folder_path, output_file_name, ref_image)
  %% This function provides a sample to use QCHR(Lam et. al. 2013) to register a reference frame against all other frames and calculate the Beltrami Descriptor. Note that this function does not automatically do the image registration parallelly as said in the paper. More is needed to be done if parallel registration is desired.

  % input_folder_path  : this folder should contain all frames. Assume all images are named from 1.png to N.png
  % number_of_frames   : the total number of frames
  % output_folder_path : the BC descriptor, as a txt file, will be written into this folder
  % output_file_name   : the name of the txt file
  % ref_image          : the name of the reference image inside input_folder_path

  %% Add the necessary path
  addpath('mfile');

  %% Read the reference frame
  ref_image = imread(strcat(input_folder_path, ref_image));
  if size(ref_image,3) == 3
    ref_image = rgb2gray(ref_image); % since the code could only work on grayscale images
  end
  ref_image = im2double(ref_image);

  beltrami_descriptor = [];
  for ptr = 1 : number_of_frames
    % Read each image
    current_image = imread(strcat(input_folder_path, int2str(ptr), '.png'));
    if size(current_image,3) == 3
      current_image = rgb2gray(current_image);
    end
    current_image = im2double(current_image);
    
    [~,mu,~,~,~,~] = QCIR(ref_image, current_image, [1], [0,0]); % As the code needs at least one point as landmark to initialize, it is chosen as the corner.
    beltrami_descriptor = horzcat(beltrami_descriptor,mu);
  end

  save(strcat(output_folder_path, output_file_name), 'beltrami_descriptor')
end
