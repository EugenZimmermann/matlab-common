function [status] = check_range(value,start,stop)
%CHECKTYPE Summary of this function goes here
%   Detailed explanation goes here
    
    try
        status = value>=start && value<=stop;
        if ~status
            errordlg(['Input must be between ',num2str(start),' and ',num2str(stop)], 'Error')
        end
    catch error
        disp('Error in IVSetup\check_value');
        disp(error.identifier)
        disp(error.message)
        status = 0;
    end
end

