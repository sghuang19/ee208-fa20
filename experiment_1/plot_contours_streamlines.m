function plot_contours_streamlines(charges, xm, ym, Vmin, Vmax)
    % plot_contours_streamlines - to plot the contours distribution
    % input arguments -
    %   charges - a matrix with 3 rows,
    %            row 1 indicates point charge amount;
    %            row 2 indicates x-coordinate;
    %            row 3 indicates y-coordinate
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction
    %   Vmin - the minimum potential value for a family of equipotential lines
    %   Vmax - the maximum potential value for a family of equipotential lines

    V = potential(charges, xm, ym);
    figure
    % form a grid
    grid on

    % set the potential for 20 equipotential lines
    Veq = linspace(Vmin, Vmax, 30);
    % plot 20 equipotential lines
    contour(V{2}, V{3}, V{1}, Veq);
    % hold the plot
    hold on

    % plot streamlines
    % calculation of two components of Electric Field intensity at each Point in the Field
    [Ex, Ey] = gradient(-V{1});
    % set the angle difference between adjacent field lines
    del_theta = 15;
    % express the angle into radian
    theta = (0:del_theta:360) .* pi / 180;
    xs = [];
    ys = [];

    for index = 1:size(charges, 1)
        % generate the x coordinate for the start of the field line
        x = charges(index, 2);
        xs = [xs, x + xm / 20 * cos(theta)];
        % generate the x coordinate for the start of the field line
        y = charges(index, 3);
        ys = [ys, y + ym / 20 * sin(theta)];
    end

    xs = [xs, 10 * xm * cos(theta)];
    ys = [ys, 10 * ym * sin(theta)];

    % generate the field lines
    streamline(V{2}, V{3}, Ex, Ey, xs, ys)
    % hold the plot
    hold on

    % plot the charges
    for index = 1:size(charges, 1)
        x = charges(index, 2);
        y = charges(index, 3);
        plot(x, y, '*', 'MarkerSize', 12)
    end

    % title the plot
    title({('Isopotential lines and power lines of point charge(s) electric field in vacuum'); ...
            ('(Expressed by Smooth Continuous Curves)')}, 'fontsize', 12)
    % label the x axis
    xlabel('X axis(unit: m)', 'fontsize', 12, 'fontname', 'Times New Roman')
    % label the y axis
    ylabel('Y axis (unit: m)', 'fontsize', 12, 'fontname', 'Times New Roman')
end
