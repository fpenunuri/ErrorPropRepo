%u = vuni(v), unit vector on directionof v
%u = vuni(v,dim), the elements of v are made unit vectors along dimension 
%dim

function fr = vuni(varargin)
  v = varargin{1};
  fr = v./sqrt(sum(v.*v,varargin{2:end}));
end
