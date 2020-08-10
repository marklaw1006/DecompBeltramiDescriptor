# Decomposition of Longitudinal Deformations via Beltrami Descriptors

This code corresponds to the following paper:

[Decomposition of Longitudinal Deformations via Beltrami Descriptors](http://arxiv.org/abs/2008.03154)

Ho Law, Lok Ming Lui, Chun Yin Siu

### Getting started

#### Software Requirement
- MATLAB with Image Processing Toolbox

Note that this software was developed in the version of R2018b. Yet it is believed that it shall be compatible with older versions.

#### Download Examples

Due to the storage limit on Github, to download examples presented in the paper, please visit:

[My Google Drive](https://drive.google.com/file/d/1ndKX_Hw2XDas64u6aDwafUCxstWWdgJQ/view?usp=sharing)

After downloading and unziping, put the folder ***data*** at the same level of ***main.m***.

### Usage

#### Running Demo Examples

After downloading the data, by properly commenting and uncommenting the first few lines on ***main.m*** and running it, you shall view the result of the chosen example. 

    >> main

#### Applying this method to your own data

##### 1. Frames Registration

Before you try to apply the proposed method to your data, you need to do the image registration from a chosen reference frame to all other frames and find the Beltrami Descriptor. 

To do so, a sample registration process that could automatically generate the Beltrami Descriptor is included in the file ***sample_registration.m***. Note that by default this code registers frames one by one. Due to the absence of Parallel Computing Toolbox in the author's MATLAB version, he fails to make sure the code would work with *parfor*(but it should). Thus, users shall make the adjustment for parallel registration.

Also note that in the ***sample_registration.m***, it assumes that all images are named from *1.png* to *\<N\>.png*. Adjust accordingly if that is not how you name the frames.

After registration and stacking up the Beltrami Descriptors as mentioned in the paper, you shall have a *mat* file that stores this Beltrami Descriptor. By default, it is named ***mu.mat***, or you could change accordingly in ***main.m***.

##### 2. Parameters Tuning

Depending on the Beltrami Descriptor, there could be a need to tune the parameter `lambda` for the best performance and diffeomorphic property. Also, if you find that convergence is slow, you might also want to tune the `max_mu` in ***mfile/complex_rpca.m***.

##### 3. Output Frames

After running the main decomposition algorithm, with a specified output phat, the program should automatically recover the images. In the output folder, the ***low_rank*** folder stores the frames that constitute a video without abnormal motion, while the ***sparse*** folder stores the frames of the video of abnormal motion acting on the reference frame.

Same as step one, although this process can be done parallel, the author cannot make sure the parallel code works. Therefore, please make adjustment if you desire a parallel recovery.
