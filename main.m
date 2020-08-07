function main(varargin)
  %% Selectively commenting and uncommenting here to choose the example you would like to run
  % Synthetic experiment
  names = load('example_param/synthetic_example.mat');
  % First Heart experiment
  %names = load('example_param/first_heart_example.mat');
  % Second Heart experiment
  %names = load('example_param/second_heart_example.mat');
  % First Lung experiment
  %names = load('example_param/first_lung_example.mat');
  % Second Lung experiment
  %names = load('example_param/second_lung_example.mat');
  addpath('mfile')

  mu_file         = names.mu_file;
  mu_gt_file      = names.mu_gt_file;
  output_file     = names.output_file;
  ref_image_name  = names.ref_image_name;
  image_file      = names.image_file;
  experiment_name = names.experiment_name;
  
  fprintf('Now Performing %s Experiment...\n',experiment_name);
  mu = load(mu_file);
  lambda  = 3e-3; % shall be fine-tuned upon different examples.
  tol = 1e-7;
  maxiter = 1000;
  for i = 1:length(varargin)
    if isa(varargin{i},'double') 
        continue;
    end
    if ~isempty(regexp(varargin{i},'^[Mm]u_file','match'))
        mu_file = varargin{i+1};
    end
    if ~isempty(regexp(varargin{i},'^[Ll]ambda','match'))
        lambda= varargin{i+1};
    end
    if ~isempty(regexp(varargin{i},'^[Tt]ol','match'))
        tol = varargin{i+1};
    end
    if ~isempty(regexp(varargin{i},'^[Mm]axiter','match'))
        maxiter = varargin{i+1};
    end
    if ~isempty(regexp(varargin{i},'^[Rr]ef_image_name','match'))
        ref_image_name = varargin{i+1};
    end
  end

  data = load(mu_file);
  mu = data.mu;
  % Compare with groundtruth if available
  if ~isempty(mu_gt_file) 
    gt_data = load(mu_gt_file);
    gt_mu = gt_data.mu;
  end
  
  % Put into complex_rpca.
  [L,S,~] = complex_rpca(mu,lambda,tol,maxiter);
  L = sparse(L); S = sparse(S);
    
  % Visualization
  view_pics(image_file,output_file,L,S,'ref_image_name',ref_image_name);

  if ~isempty(mu_gt_file) % compare with groundtruth if available
    fprintf('The groundtruth rank of mu is %d ...\n', rank(full(gt_mu)));
  end
  fprintf('The recovered rank of L is %d ...\n', rank(full(L)));
  fprintf('The recovered rank of S is %d ...\n', rank(full(S)));
 
end
