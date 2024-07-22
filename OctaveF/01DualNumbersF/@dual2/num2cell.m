%C = num2cell (A)
%C = num2cell (A, DIM)
%Convert the numeric matrix A to a cell array.
%A can have dual numbers as elements.

function fr = num2cell(varargin)
[args{1:nargin}] = varargin{:};
arr = args{1};

g0 = arr.f0;  
g1 = arr.f1;
g2 = arr.f2;


args0 = args;
args0{1} = g0;

args1 = args;
args1{1} = g1;

args2 = args;
args2{1} = g2;


fr0 = num2cell(args0{:});
fr1 = num2cell(args1{:});
fr2 = num2cell(args2{:});


fr = cellfun(@(x0,x1,x2) dual2(x0,x1,x2), fr0, fr1, fr2, ...
    'UniformOutput', false);

end



