%>  Greater than.
%   A > B
% There is no order on the dual4 numbers. The comparison is made 
% between the f0 components (real components).
%
function fr = gt(A,B)

  if(isnumeric(A))
    A = dual4(A);
  end

  if(isnumeric(B))
    B = dual4(B);
  end

  A0 = A.f0;
  B0 = B.f0;

  fr = builtin('gt',A0,B0);
end



