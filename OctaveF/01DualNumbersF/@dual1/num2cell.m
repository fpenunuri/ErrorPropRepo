%C = num2cell (A)
%C = num2cell (A, DIM)
%Convert the numeric matrix A to a cell array.
%A can have dual1 numbers as elements.

function fr = num2cell(varargin)
[args{1:nargin}] = varargin{:};
arr = args{1};

g0 = arr.f0;  
g1 = arr.f1;

args0 = args;
args0{1} = g0;

args1 = args;
args1{1} = g1;

fr0 = num2cell(args0{:});
fr1 = num2cell(args1{:});


fr = cellfun(@(x,y) dual1(x,y), fr0, fr1, 'UniformOutput', false);

end



