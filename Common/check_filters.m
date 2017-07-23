function [result,status] = check_filters(string)
% check if given value is a string with valid filter condition: Yx2 double array
% This function checks if given value valid string for given condition.
% INPUT:
%   string: String, or 1D cell containing a string.
%   condition: numeric data in array 6x2, 12x2, 24x2
%
% OUTPUT:
%   result: (Converted) string value of input.
%	status: 1 if string is valid for chosen condition

% Tested: Matlab 2017a, Win10
% Author: Eugen Zimmermann, Konstanz, (C) 2017 eugen.zimmermann@uni-konstanz.de

input = inputParser;
addRequired(input,'string');
parse(input,string);

    try
        if iscell(string)
            string = string{1};
        end
        
        if ~ischar(string)
            errordlg('Input is not a string!', 'Error')
            result = -666;
            return
        end
        
        tempFilter = regexp(string,',','split');
        posFilters = str2double(tempFilter(1:2:end-1))';
        checkPos = ~sum(isnan(posFilters)) && min(posFilters)>0 && max(posFilters<24);
        
        lambdaFilters = str2double(tempFilter(2:2:end))';
        checkLambda = ~sum(isnan(lambdaFilters)) && min(lambdaFilters)>=0 && max(lambdaFilters<1800);
        
        if checkPos && checkLambda
            result = sortrows([posFilters,lambdaFilters],2);
            status = 1;
        else
            result = [1,1800];
            status = 0;
        end
        
    catch error
        errordlg(['Error in check_filters for input argument ',string,'.']);
        disp(error.identifier)
        disp(error.message)
        
        result = -777;
        status = 0;
    end
end

