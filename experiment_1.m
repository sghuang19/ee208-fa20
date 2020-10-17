% clear all variables in memory
clear

% clear the figures window
close all

% set electrostatic constant
global k
k = 9e9;

charges_1 = [1e-9, -0.01, 0; 1e-9 0.01 0];
charges_2 = [5e-9, -2, 0; -5e-9 2 0];
charges_3 = [8e-9, -sqrt(3), -1; 8e-9 sqrt(3) -1; 8e-9, 0, 2];

% calculate electric potential distribution
potential_1 = potential(charges_1, 0.02, 0.02);
potential_2 = potential(charges_2, 5, 5);
potential_3 = potential(charges_3, 5, 5);

% plot electric potential distribution
plot_potential(potential_1)
plot_potential(potential_2)
plot_potential(potential_3)

% plot potential contours
plot_contours(charges_1, 0.02, 0.02, 200, 2000);
plot_contours(charges_2, 5, 5, -25, 25);
plot_contours(charges_3, 5, 5, 0, 200);

%% potential
function V = potential(charges, xm, ym)
    % potential - to calculate the electric potential distribution
    %
    % input -
    %   charges - a matrix with 3 rows,
    %            row 1 indicates point charge amount;
    %            row 2 indicates x-coordinate;
    %            row 3 indicates y-coordinate
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction
    %
    % output -
    %   V - a cell of three elements,
    %      the first indicates the x-coordinate of the meshgrid
    %      the second indicates the y-coordinate of the meshgrid
    %      the third indicates the potential at each points in the range

    % evenly divide the x axis into 40 segments
    x = linspace(-xm, xm, 40);

    % evenly divide the y axis 40 segments
    y = linspace(-ym, ym, 40);

    % to form the coordinates of each point in the field.
    [X, Y] = meshgrid(x, y);

    q_num = size(charges, 1);

    % calculate the distance between each point and the source charge (the origin).
    R = {};

    for index = 1:q_num
        R{index} = ...
            sqrt((X - charges(index, 2)).^2 + ...
            (Y - charges(index, 2)).^2);
    end

    % calculate the electric potential of each point
    % V = k * Q ./ R;
    global k
    V_q = {};

    for index = 1:q_num
        V_q{index} = ...
            k * charges(index, 1) ./ R{index};
    end

    V_total = sum(cat(3, V_q{:}), 3);
    V = {X, Y, V_total};

end

%% plot_potential
function plot_potential(V)
    % potential - to plot the electric potential distribution
    % input aruguments -
    %   V - a cell of three elements,
    %      the first indicates the x-coordinate of the meshgrid
    %      the second indicates the y-coordinate of the meshgrid
    %      the third indicates the potential at each points in the range
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction

    figure

    mesh(V{1}, V{2}, V{3});

    % The title for the plot(Note that all symbols should be half-angled English characters )
    title("The plot of electric potential distribution of a point charge in the vacuum");
    % label the x axis
    xlabel('X axis (unit: m)');
    % label the y axis
    ylabel('Y axis (unit: m)');
end

%% plot_contours
function plot_contours(charges, xm, ym, Vmin, Vmax)
    % plot_contours - to plot the contours distribution
    % input aruguments -
    %   charges - a matrix with 3 rows,
    %            row 1 indicates point charge amount;
    %            row 2 indicates x-coordinate;
    %            row 3 indicates y-coordinate
    %   Vmin - the minimum potential value for a family of equipotential lines
    %   Vmax - the maximum potential value for a family of equipotential lines

    % set the potential for 10 equipotential lines
    Veq = linspace(Vmin, Vmax, 20);

    V = potential(charges, xm, ym);

    % plot 20 equipotential lines
    figure
    contour(V{1}, V{2}, V{3}, Veq);
    % form a grid
    grid on
    % hold the plot
    hold on

    % plot the charges
    for index = 1:size(charges, 1)
        x = charges(index, 1);
        y = charges(index, 2);
        plot(x, y, '*', 'MarkerSize', 12)
    end

    title('Isopotential Line of Point Charge(s) Electric Field in Vacuum');
    % title the plot
    xlabel('X axis (unit: m)'); % label the x axis
    ylabel('Y axis (unit: m)'); % label the y axis

end
