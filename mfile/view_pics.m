function view_pics(pics_path, output_pics_path, low_rank_matrix, sparse_matrix,varargin)
  %% This function regenerates pictures based on the given low_rank_matrix and sparse_matrix that are obtained from complex_rpca.m
  % pics_path        : the path where the pictures are stored
  % output_pics_path : the path to store the recovered pics.
  % low_rank_matrix  : decomposed low rank matrix obtained from the main algorithm
  % sparse_matrix    : decomposed sparse matrix obtained from the mainalgorithm
  % varargin         : ref_image_name if it's not '1.png'

  ref_image_name = '1.png';
  for i = 1 : length(varargin)
    if isa(varargin{i},'double')
      continue;
    end
    if ~isempty(regexp(varargin{i},'^[Rr]ef_image_name','match'))
        ref_image_name = varargin{i+1};
    end
  end

  low_rank_pics_path = strcat(output_pics_path,'low_rank/');
  sparse_pics_path   = strcat(output_pics_path,'sparse/');
  if ~exist(low_rank_pics_path)
    mkdir(low_rank_pics_path)
  end
  if ~exist(sparse_pics_path)
    mkdir(sparse_pics_path)
  end

  % Read and preprocess the reference image
  ref_image = imread(strcat(pics_path,ref_image_name));
  if size(ref_image,3) == 3, ref_image = rgb2gray(ref_image); end
  ref_image = im2double(ref_image);
  imwrite(ref_image,strcat(low_rank_pics_path,ref_image_name));

  % Get height and width
  [h,w] = size(ref_image);
  % For image recovery
  [f,v] = image_meshgen(h,w);
  v = v(:,1:2);

  % Recover image by image
  for col = 1 : size(low_rank_matrix,2)
    fprintf('Recovering image %d ... \n',col);
    low_rank_col = full(low_rank_matrix(:,col));
    sparse_col   = full(sparse_matrix(:,col));

    % Reconstruct the low rank part
    [new_low_rank_pic,low_rank_map] = recover_low_rank_image(low_rank_col,f,v,h,w,ref_image);
    imwrite(new_low_rank_pic,strcat(low_rank_pics_path,int2str(col),'.png'));

    % Reconstruct the sparse part
    sparse_image = reconstruct_sparse_image(low_rank_map,ref_image,low_rank_col,sparse_col,f,v,h,w);
    imwrite(sparse_image,strcat(sparse_pics_path,int2str(col),'.png'));
  end
end

function [low_rank_image,low_rank_map] = recover_low_rank_image(L_col,f,v,h,w,from_image)
  low_rank_map   = lbs_rect(f,v,L_col,'height',h-1,'width',w-1);
  low_rank_image = warpimage(from_image,[h,w],v,low_rank_map);
end

function sparse_image = reconstruct_sparse_image(low_rank_map,from_image,low_rank_col,sparse_col,f,v,h,w)
  sparse_map   = lbs_rect(f,v,sparse_col,'height',h-1,'width',w-1);
  sparse_image = warpimage(from_image,[h,w],v,sparse_map);
end
