%CAT Concatenate arrays.
%   CAT(DIM,A,B) concatenates the arrays A and B along
%   the dimension DIM. 
% The arrays can be dual1 numbers

%for Matlab

%function fr = cat(n,varargin)
%  vecd = builtin('horzcat',varargin{:});
%
%  g0 = {vecd.f0};
%  g1 = {vecd.f1};
%  
%  g0 =  builtin('cat',n,g0{:});
%  g1 =  builtin('cat',n,g1{:});
%
%  fr = dual1(g0,g1);
%end


function fr = cat(n,varargin)

  g0 = cellfun(@(x) dual1(x).f0, varargin, 'UniformOutput', false);
  g1 = cellfun(@(x) dual1(x).f1, varargin, 'UniformOutput', false);
  
  g0 =  builtin('cat',n,g0{:});
  g1 =  builtin('cat',n,g1{:});

  fr = dual1(g0,g1);
end
