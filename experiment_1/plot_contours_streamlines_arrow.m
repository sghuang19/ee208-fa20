function plot_contours_streamlines_arrow(charges, xm, ym, Vmin, Vmax)
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
    % calculation of two components of Electric Field intensity at each Point in the Field
    [Ex, Ey] = gradient(-V{1});

    % calculate the magnitude of electric field magnitude at each point.
    E = sqrt(Ex.^2 + Ey.^2);
    Ex = Ex ./ E;
    % normalize the magnitude of the electric field
    Ey = Ey ./ E;
    figure
    % using normalized arrowhead to represent electric field
    s = fix(size(V{3}) / 15);
    quiver(V{2}(1:s:end, 1:s:end), ...
        V{3}(1:s:end, 1:s:end), ...
        Ex(1:s:end, 1:s:end), ...
        Ey(1:s:end, 1:s:end))
    hold on

    % set the potential for 30 equipotential lines
    Veq = linspace(Vmin, Vmax, 30);
    % plot the equipotential lines
    contour(V{2}, V{3}, V{1}, Veq)
    hold on

    % plot the charges
    for index = 1:size(charges, 1)
        x = charges(index, 2);
        y = charges(index, 3);
        plot(x, y, '*', 'MarkerSize', 12)
    end

    % title the graph
    title({('Equipotential lines and electric field lines of point charge(s) electric field in vacuum'); ...
            ('(represented by normalized arrowhead)')}, 'fontsize', 12)
    % label the X axis
    xlabel('X axis(unit:m)', 'fontsize', 12, 'fontname', 'Times New Roman')
    % label the Y axis
    ylabel('Y axis(unit:m)', 'fontsize', 12, 'fontname', 'Times New Roman')

end
