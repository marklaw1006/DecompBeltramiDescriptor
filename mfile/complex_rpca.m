function [A,E,iter] = complex_rpca(X,lambda,tol,maxiter)
%% inexact_alm_crpca.m
% Complex Robust Principal Component Analysis
%   solve min |A|_*+lambda|E|_1 s.t. X = A+E
%   using the inexact augmented Lagrangian method (IALM)
% ----------------------------------
% Tak-Shing Chan 16-Jul-2015
% takshingchan@gmail.com
% Copyright: Music and Audio Computing Lab, Academia Sinica, Taiwan

% Modified by Ho Law 5-Aug-2020
% hlawab@connect.ust.hk
%%

[m,n] = size(X);

% initialization
A = zeros(m,n);
X_2 = svds(X,1,'L');
X_inf = norm(X(:),inf);
X_fro = norm(X(:));

% parameters from Lin et al. (2009; can be tuned)
mu = 1.25/X_2;
Y = X/max(X_2,X_inf/lambda);
rho = 1.5;
max_mu = (rho^20) * mu;

old_max_E = 0;
last_iter_larger_1 = 0;
for iter = 1:maxiter
    fprintf('Running iter %d ...\n',iter);
    %% update E
    E = X-A+Y/mu;
    E = max(1-(lambda/mu)./abs(E),0).*E;

    %% update A
    [U,S,V] = svd(X-E+Y/mu,'econ');
    S = diag(S)-1/mu;
    r = length(find(S>0));
    A = U(:,1:r)*diag(S(1:r))*V(:,1:r)';

    R = X-A-E;

    Y = Y+mu*R;
    mu = rho*mu;
    if mu > max_mu
      mu = max_mu;
    end

    if iter ~= 1
      new_max_E = max(abs(E(:)));
      %{
      if new_max_E < old_max_E
        display("Maximum Norm of E is Decreasing...");
      elseif new_max_E > old_max_E
        warning("Maximum Norm of E is NOT Decreasing...");
      end
      %}
      if new_max_E >= 1
        warning("Maximum Norm of E is NOT smaller than 1...");
        last_iter_larger_1 = iter;
      end
      %{
      if new_max_E < 1
        display("The Maximum Norm is smaller than 1...");
      else
        warning("Maximum Norm of E is NOT smaller than 1...");
        last_iter_larger_1 = iter;
      end
      %}
      old_max_E = new_max_E;
    end
    %% check for convergence
    if norm(R(:))/X_fro<tol
        return
    end
end
fprintf('rank of low-rank matrix is %d...\n',rank(A));
if last_iter_larger_1 ~= 0
  fprintf('The last iter with magnitude larger than or equal to 1 is %d ...\n',last_iter_larger_1);
end
disp('Maximum iterations exceeded');
