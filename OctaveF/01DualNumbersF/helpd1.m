function  helpd1(fname)

str0 = pwd;
disp(str0)
disp('----')
str1= '/home/frpa/Documents/MisDocumentos/Trabajos/GitWorks/ErrorP/';
str2= 'ErrorPropagationDN/OcatveF/01DualNumbersF/';

if  strfind(fname,'.m')
    fr = strcat(str1,str2,fname);
else
    fr = strcat(str1,str2,fname,'.m');
end

    help(fr)
end


function current_directory = get_current_directory()
    % Get the full path of the current function
    full_path = mfilename('fullpath');
    
    % Extract the directory part of the path
    current_directory = fileparts(full_path);
end
