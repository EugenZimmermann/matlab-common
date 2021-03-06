function fileList = getAllFiles(DirToRead)
%GETALLFILES Summary of this function goes here
%   Detailed explanation goes here
    dirData = dir(DirToRead);                          %# Get the data for the current directory
    dirIndex = [dirData.isdir];                         %# Find the index for directories
    fileList = {dirData(~dirIndex).name}';              %'# Get a list of the files
    if ~isempty(fileList)
    %     fileList = cellfun(@(x) strcat([dirName,'\'],x),fileList,'UniformOutput',0)
        fileList = cellfun(@(x) fullfile(DirToRead,x),...	%# Prepend path to files
        fileList,'UniformOutput',false);
    end


    subDirs = {dirData(dirIndex).name};                 %# Get a list of the subdirectories
    validIndex = ~ismember(subDirs,{'.','..'});         %# Find index of subdirectories
                                                        %#   that are not '.' or '..'
    for iDir = find(validIndex)                         %# Loop over valid subdirectories
        nextDir = fullfile(DirToRead,subDirs{iDir});   %# Get the subdirectory path
        fileList = [fileList; getAllFiles(nextDir)];    %# Recursively call getAllFiles
    end
end

