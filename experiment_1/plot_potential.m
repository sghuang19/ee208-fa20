%% plot_potential
function plot_potential(V)
    % potential - to plot the electric potential distribution
    % input arguments -
    %   V - a cell of three elements,
    %      the first indicates the x-coordinate of the meshgrid
    %      the second indicates the y-coordinate of the meshgrid
    %      the third indicates the potential at each points in the range

    figure
    mesh(V{2}, V{3}, V{1})

    % The title for the plot(Note that all symbols should be half-angled English characters)
    title("The plot of electric potential distribution of point charge(s) in the vacuum");
    % label the x axis
    xlabel('X axis (unit: m)', 'fontname', 'Times New Roman');
    % label the y axis
    ylabel('Y axis (unit: m)', 'fontname', 'Times New Roman');
end
