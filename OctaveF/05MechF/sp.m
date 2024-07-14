%scalar product intended to be used with the complex steep approximation 
%method (there is no conjugation for the complex case)
%fr = sp(a,v,dim)
function fr = sp(varargin)
  a = varargin{1};
  b = varargin{2};

  fr = sum(a.*b,varargin{3:end});
end
