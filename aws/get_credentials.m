function [aws_id,aws_key] = get_credentials(credentials_path)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% File formatted like
%aws_access_key_id=XXXXXXXXXXXXXXXXXXX
%aws_secret_access_key=XXXXXXXXXXXXXXXXXXX

%% Load AWS Credentials
fileID = fopen(credentials_path);
delimiter = '=';
formatSpec = '%s%[^\n\r]';
creden = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);

aws_id = creden{1,2}(1,1);
aws_key = creden{1,2}(2,1);

end

