function a = lineGraph(x, y, theta, varargin)
    
    numvarargs = length(varargin);
    if numvarargs > 1
        error('myfuns:somefun2Alt:TooManyInputs', ...
        'requires at most 3 optional inputs');
    end
    
    optargs = {100};
    optargs(1:numvarargs) = varargin;
    [space] = optargs{:};
    
    x1 = [ones(space, 1), linspace(min(x), max(x), space)'];
    for d=2:size(theta, 1)-1
        x1(:, d+1) = x1(:, 2).^d;
    end
    y1 = x1*theta;
    
    plot(x1(:, 2), y1, "r-");
    hold on;
    plot(x, y, "bx");
end