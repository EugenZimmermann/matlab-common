function [result,status] = check_ip(value)
% check if given value is an valid IP: string/1D cell
% This function checks if given value corresponds to a valid IP.
% INPUT:
%   string: String, or an 1D cell containing a string.
%
% OUTPUT:
%   result: (Converted) string value of input.
%	status: 1 if string is valid for chosen condition

% Tested: Matlab 2014a, 2014b, 2015a, Win8
% Author: Eugen Zimmermann, Konstanz, (C) 2015 eugen.zimmermann@uni-konstanz.de
% Last Modified on 2015-11-12

    result = '';
    try
        if iscell(value)
            value = value{1};
        end

        if ischar(value)
            temp = regexpi(value,'[.]','split');
            status = length(temp)==4 & min(size(temp))==1;
            if status
                temp2 = cellfun(@(s) str2double(s),temp);
                for n1 = 1:4
                    [result,status2] = check_value(temp2(n1),1,255);
                    status = status & status2;
                end
                result = value;
            end
        else
            status = 0;
        end
        
        if ~status
            errordlg('IP has to be a string in the form ''###.###.###.###'' with numeric values between 1 and 255.', 'Error')
        end
    catch error
        errordlg(['Error in check_ip for input argument ',value,'.']);
        disp(error.identifier)
        disp(error.message)
        status = 0;
    end
end

