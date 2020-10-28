%% plot_contours
function plot_contours(charges, xm, ym, Vmin, Vmax)
    % plot_contours - to plot the contours distribution
    % input aruguments -
    %   charges - a matrix with 3 rows,
    %            row 1 indicates point charge amount
    %            row 2 indicates x-coordinate
    %            row 3 indicates y-coordinate
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction
    %   Vmin - the minimum potential value for a family of equipotential lines
    %   Vmax - the maximum potential value for a family of equipotential lines

    V = potential(charges, xm, ym);
    % set the potential for 10 equipotential lines
    Veq = linspace(Vmin, Vmax, 30);

    % plot 20 equipotential lines
    figure
    contour(V{2}, V{3}, V{1}, Veq);
    % form a grid
    grid on
    % hold the plot
    hold on

    % plot the charges
    for index = 1:size(charges, 1)
        x = charges(index, 2);
        y = charges(index, 3);
        plot(x, y, '*', 'MarkerSize', 12)
    end

    title('Isopotential lines of point charge(s) electric field in vacuum');
    % title the plot
    xlabel('X axis (unit: m)', 'fontname', 'Times New Roman'); % label the x axis
    ylabel('Y axis (unit: m)', 'fontname', 'Times New Roman'); % label the y axis

end
