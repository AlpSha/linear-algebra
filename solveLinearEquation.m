function result = solveEquation(M)

    [m, n] = size(M);
    
    tinyNumber = 1e-6;
    pivotLocations = zeros(m, 1);
    
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
        pivotLocations(r) = c;
        M(r, :) = M(r, :) / M(r, c);
        for t=r+1:m
            % Making every field zero below the field
            k = -M(t, c);
            if ~(k == 0 || isnan(k))
                M(t, :) = M(t, :) + k * M(r, :);
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
    forwardPhase = M;
    
    % Backward phase
    for r=m:-1:1
        % No solution if zero = nonzero
        if M(r, end) ~= 0 && nnz(M(r, :)) == 1
            disp("This equation has no solution.");
            M = forwardPhase;
            break;
        end
        % Scaling current field to 1 if it is not zero
        % and if it is pivot column. Zero means no pivot field on that
        % row
        c = pivotLocations(r);
        if c == 0
            continue;
        end
        curValue = M(r, c);
        % if current value is zero, than there is no pivot on this row
        if curValue == 0
            continue;
        end
        M = scale(M, r, 1/curValue);
        for t=r-1:-1:1
            % Making every field zero above the row r, column c
            k = -M(t, c);
            if k ~= 0
                M(t, :) = M(t, :) + k * M(r,:);
            end
        end
    end
   
    % Assign the result
    result = M;
    
end