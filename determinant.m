function result = determinant(M, varargin)
%% This function takes a matrix and returns its determinant
% You can specify row or column number you want to make expension on
% as second argument. Otherwise, it is accepted as first row.
% You can specify column as 'col' to make expension on specified column.
% Otherwise the number specified in second argument will be used as row number.
% Example: determinant(M, 2, 'col')

numvarargs = length(varargin);
if numvarargs > 2
    error('myfuns:somefun2Alt:TooManyInputs',...
        'requires at most 2 optional input');
end

optargs = {1, 2};
optargs(1:numvarargs) = varargin;
[expNum] = optargs{1};
[expDim] = optargs{2};


[m, n] = size(M);

if m ~= n
    error('myfuns:somefun2Alt:InvalidMatrix',...
        'Matrix must be square');
end

if m == 2
    result = M(1) * M(4) - M(2)*M(3);
    return;
end

if numvarargs < 2
    if numvarargs == 0
    expNum = 1;
    end
    expDim = 'row';
end

N = M;

if strcmp(expDim, 'col')
    coefs = N(:,expNum);
    N(:,expNum) = [];
else
    coefs = N(expNum,:);
    N(expNum,:) = [];
end

total = 0;
for i=1:length(coefs)
    K = N;
    if strcmp(expDim, 'col')
        K(i,:) = [];
    else
        K(:,i) = [];
    end
    total = total + ((-1)^(expNum+i))*coefs(i)*determinant(K);
end

result = total;

