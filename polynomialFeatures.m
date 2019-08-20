function result = polynomialFeatures(X, varargin)

    numvarargs = length(varargin);
    if numvarargs > 2
        error('myfuns:somefun2Alt:TooManyInputs', ...
            'requires at most 2 optional inputs');
    end

    optargs = {2, 1};
    optargs(1:numvarargs) = varargin;
    [degree, col_ones] = optargs{:};

    
    for d=2:degree
        X(:, d) = X(:, 1).^d;
    end
    
    if col_ones
        X = [ones(size(X, 1), 1), X];
    end
    
    result = X;
    
end
