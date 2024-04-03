clc % GUI cleaning.
clearvars % GUI cleaning.
close all % GUI cleaning.

fileID = fopen('result.csv', 'r'); % Open the CSV file for reading

sumOfErrors = 0; % the sum of all residuals.
howManySamples = 0; % how many sample the file contains.
theoreticalVerificationCheck = "OK"; % If OK the model is theoretically correct.


while ~feof(fileID) % Read each line of the CSV file
    line = fgetl(fileID); % get a line from the CSV file.
    binaryNumbers = strsplit(line, ';');  % Split the line into binary numbers using the separator ";"
    
    % Convert the first two binary numbers into signed 10-bit decimals.
    realPart = binaryToSignedDecimal(binaryNumbers{1});
    imgPart = binaryToSignedDecimal(binaryNumbers{2});
    
    % Convert the third binary number into an unsigned 11-bit decimal.
    approx = binaryToSignedDecimal(binaryNumbers{3});
    
    expectedResult = sqrt((realPart^2) + (imgPart^2)); % Compute the approximated (the real one) function.

    if(approx ~= theoreticalVerification(abs(realPart) , abs(imgPart))) % Theoretical verification of the circuit.
        % Even if a single result is not correct, the theoretical verification fails.
        theoreticalVerificationCheck = "NOT OK";
    end
    error = (expectedResult - approx)^2; % Compute the error on the approximation.
    sumOfErrors = sumOfErrors + error; % Sum the error to the total sum.
    howManySamples = howManySamples + 1; % Increent the number of samples.
end

MSE = sumOfErrors / howManySamples; % Compute the mean square error (MSE).

fclose(fileID); % Close the file.

clear ans binaryNumbers line imgPart realPart sumOfErrors; % GUI cleaning.
clear  error approx expectedResult fileID; % GUI cleaning.

function decimalNumber = binaryToSignedDecimal(binaryNumber)
% MATLAB does not have a built in function for convert a signed integer to
% the related decimal integer.
% So i write a function equivalent to bin2dec but for signed integers.
num_bits = numel(binaryNumber);  % Calculate the number of bits of the input number.
    decimalNumber = 0; % Initialize the output decimal number.
    
    if binaryNumber(1) == '1' % Check the most significant bit.
        % If the most significant bit is 1, the number is a negative integer.
        for i = 2:num_bits
            % Invert the bits and add 1 to get the two's complement.
            if binaryNumber(i) == '0'
                decimalNumber = decimalNumber + 2^(num_bits-i);
            end
        end
        % Multiply by -1 to get the negative value
        decimalNumber = (-1*decimalNumber) - 1;
    else
        % If the most significant bit is 0, the number is positive.
        % then i can use the MATLAB's built-in function.
        decimalNumber = bin2dec(binaryNumber);
    end
end

function res = theoreticalVerification(real , img)
   max = 0;
   min = 0;

   if(real >= img)
       % Compute the max and the min.
       max = real;
       min = img;
   else
       max = img;
       min = real;
   end

   res = (max + floor(min / 2)) - floor((max + min)/16); % compute the formula.
end


