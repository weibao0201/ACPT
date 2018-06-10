%----------------------------------------------------------------------
%
%       BOX VOLUME MAXIMIZATION EXAMPLE IN SPARSE FORMAT
%
%----------------------------------------------------------------------
%
%   maximize:   h^-1*w^-1*d^-1
%   subject to: (2/Awall)*h*w+(2/Awall)*h*d <= 1,
%               (1/Aflr)*w*d <= 1,
%               alpha*h^-1*w <= 1,
%               (1/beta)*h*w^-1 <= 1,
%               gamma*w*d^-1 <= 1,
%               (1/delta)*w^-1*d <= 1.
%
%   This is an example taken directly from the paper:
%       A Tutorial on Geometric Programming (see pages 8 and 13)
%       by Boyd, Kim, Vandenberghe, and Hassibi.
%

clear all; close all;

%----------------------------------------------------------------------
%      PROBLEM DATA IN POSYNOMIAL FORM (SPARSE FORMAT)
%----------------------------------------------------------------------
Aflr  = 1000;
Awall = 100;
alpha = 0.5;
beta  = 2;
gamma = 0.5;
delta = 2;

% form a sparse matrix for A
A = sparse(8,3);
  A(1,1) = -1;
  A(1,2) = -1;
  A(1,3) = -1;
  A(2,1) =  1;
  A(2,2) =  1;
  A(3,1) =  1;
  A(3,3) =  1;
  A(4,2) =  1;
  A(4,3) =  1;
  A(5,1) = -1;
  A(5,2) =  1;
  A(6,1) =  1;
  A(6,2) = -1;
  A(7,2) =  1;
  A(7,3) = -1;
  A(8,2) = -1;
  A(8,3) =  1;

% form a vector b
b   = [1 2/Awall 2/Awall 1/Aflr alpha 1/beta gamma 1/delta]';

% form a vector szs
szs = [1 2 1 1 1 1 1]'; 

%----------------------------------------------------------------------
%      SOLVE THE PROBLEM IN POSYNOMIAL FORM
%----------------------------------------------------------------------
[x1,status1,lambda1,nu1] = gpposy(A,b,szs);
% calculate the volume
vol_posy = prod(x1)

%----------------------------------------------------------------------
%      SOLVE THE PROBLEM IN CONVEX FORM
%----------------------------------------------------------------------
[x2,status2,lambda2,nu2,mu2] = gpcvx(A,log(b),szs);
% convert the result from convex form into posynomial form
vol_cvx = prod(exp(x2))

