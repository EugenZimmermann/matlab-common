function [files,nfiles] = getFiles(folder, filetype)
    try
        if isunix
            strrep(folder,'\','/');
            files_temp = dir(folder);
            files_temp = files_temp(~[files_temp.isdir]);
            % Loop through all files
            for id = 1:length(files_temp)
                % make extension lower case
                [~,fname,ext] = fileparts([folder,'/',files_temp(id).name]);
                movefile([files_temp,'/',files_temp(id).name],[files_temp,'/',fname,'.',lower(ext)]);
            end

            path = [folder,'/',lower(filetype)];
        elseif ispc
            path = [folder,'/',lower(filetype)];
            strrep(folder,'/','\');
        else
            disp('Platform not supported')
            files = struct();
            nfiles = 0;
            return
        end

        if ~exist(folder,'dir')
            disp('Folder does not exist')
            files = struct();
            nfiles = 0;
            return
        end

        files=dir(path);
        nfiles = length(files);
    catch e
        disp(e.massege)
        files = struct();
        nfiles = 0;
    end
end