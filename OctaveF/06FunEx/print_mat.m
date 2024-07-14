%print_mat(A,ndec): auxiliar function to print a matrix A with ndec decimal 
%places
function print_mat(A,ndec)
  [r, c] = size(A);  
  for i = 1:r
    for j = 1:c
      formato = sprintf('  %s%d%s%s','%.',ndec,'f ');
      fprintf(formato, A(i,j));  
    end
    fprintf('\n');  
  end
  fprintf('\n');
end
