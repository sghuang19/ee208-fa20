%% potential
function V = potential(charges, xm, ym)
    % potential - to calculate the electric potential distribution
    %
    % input -
    %   charges - a matrix with 3 rows,
    %            column 1 indicates point charge amount;
    %            column 2 indicates x-coordinate;
    %            column 3 indicates y-coordinate
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction
    %
    % output -
    %   V - a cell of three matrices,
    %      the first indicates the potential at each points in the range
    %      the second indicates the x-coordinate of the meshgrid
    %      the third indicates the y-coordinate of the meshgrid

    % evenly divide the x axis into 50 segments
    x = linspace(-xm, xm, 50);
    % evenly divide the y axis 50 segments
    y = linspace(-ym, ym, 50);

    % to form the coordinates of each point in the field.
    [X, Y] = meshgrid(x, y);

    % calculate the distance between each point and the source charge (the origin).
    R = {};

    for index = 1:size(charges, 1)
        R{index} = ...
            sqrt((X - charges(index, 2)).^2 + ...
            (Y - charges(index, 3)).^2);
    end

    % calculate the electric potential of each point
    % V = k * Q ./ R;
    global k
    V_q = {};

    for index = 1:size(charges, 1)
        V_q{index} = ...
            k * charges(index, 1) ./ R{index};
    end

    V_total = sum(cat(3, V_q{:}), 3);
    V = {V_total, X, Y};

end
