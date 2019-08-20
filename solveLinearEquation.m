function result = solveLinearEquation(M)
%% This function takes an augmented matrix as argument and calculates the solution

    [m, n] = size(M);
    
    tinyNumber = 1e-6;    
    % Forward phase of row reduction
    c = 1;
    for r=1:m
        count = 1;
        allZero = 0;
        % Swap the rows when we hit zero field
        while M(r, c) == 0
            % If already checked the last row and value is still zero, go to
            % the next column.
            if r+count > m
                % Break if also checked the last column
                if c >= n-1
                    allZero = 1;
                    break
                end
                c = c+1
                count = 1;
            elseif M(r+count, c) == 0
                count = count + 1;
            else
                M = swap(M, r, r+count);
            end
        end
        if allZero
            % Nothing left to do, all remaining fields are zero
            break;
        end
        % Continue the row reducing using the current field
        % Point this field as pivot location
        M(r, :) = M(r, :) / M(r, c);
        for t=1:m
            % Making every field zero below and above the field
            if t~= r
               k = -M(t, c);
            if ~(k == 0 || isnan(k))
                M(t, :) = M(t, :) + k * M(r, :);
            end 
            end
        end
        % Going to the next column if there is left
        if c < n-1
            c = c+1;
        else
            break;
        end
    end
    M(abs(M) < tinyNumber) = 0;

    % Assign the result
    result = M;
end