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

% plot electric field streamlines and potential contours
plot_contours_streamlines(charges_1, 0.02, 0.02, 200, 2000);
plot_contours_streamlines(charges_2, 5, 5, -25, 25);
plot_contours_streamlines(charges_3, 5, 5, 0, 200);

% plot potential field streamlines represented in unified arrows and contours
plot_contours_streamlines_arrow(charges_1, 0.02, 0.02, 200, 2000);
plot_contours_streamlines_arrow(charges_2, 5, 5, -25, 25);
plot_contours_streamlines_arrow(charges_3, 5, 5, 0, 200);

% save all the figures
for index = 1:12
    exportgraphics(get(index, 'CurrentAxes'), ['experiment_1_figure_', num2str(index), '.png'], 'Resolution', 600)
end
