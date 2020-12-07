% clear
close all

% Set the range of y direction in the field domain
zm = 3;
% Set the range of z direction in the field domain
ym = 3;
% Equally divide y axis into 20 parts
global y
y = linspace(-ym, ym, 50);
% Equally divide z axis into 20 parts
global z
z = linspace(-zm, zm, 50);

% % Case 0
% [H, Hy, Hz] = magnetic_field_intensity(0);
% magnetic_field_plot(H, Hy, Hz)

% Case 1
[~, Hy1, Hz1] = magnetic_field_intensity(1);
[~, Hy2, Hz2] = magnetic_field_intensity(-1);
Hy = Hy1 + Hy2;
Hz = Hz1 + Hz2;
H = sqrt(Hy.^2 + Hz.^2);
magnetic_field_plot(H, Hy, Hz)

% Case 2
[~, Hy1, Hz1] = magnetic_field_intensity(1);
[~, Hy2, Hz2] = magnetic_field_intensity(-1);
Hy = Hy1 - Hy2;
Hz = Hz1 - Hz2;
H = sqrt(Hy.^2 + Hz.^2);
magnetic_field_plot(H, Hy, Hz)

% save all the figures
for index = 1:6
    exportgraphics(get(index, 'CurrentAxes'), ['experiment_3_figure_', num2str(index), '.png'], 'Resolution', 600)
end

function [H, Hy, Hz] = magnetic_field_intensity(zc)

    % Input the radius of the current loop
    a = 2;
    % Input the current value in the current loop
    I = 500;
    % Merge the constants
    C = I / (4 * pi);

    % Set the number of division
    N = 50;
    % Division of the angle of circumference
    theta0 = linspace(0, 2 * pi, N + 1);
    theta1 = theta0(1:N);
    theta2 = theta0(2:N + 1);

    % The start point coordinate of each segment of the loop
    x1 = a * cos(theta1);
    y1 = a * sin(theta1);
    % The ending point coordinate of each segment of the loop
    x2 = a * cos(theta2);
    y2 = a * sin(theta2);

    % Calculate the 3 coordinate components of the midpoint of each segment of the loop
    xc = (x2 + x1) ./ 2;
    yc = (y2 + y1) ./ 2;

    % Calculate the 3 length components of each segment
    % vector dl
    dlz = 0;
    dlx = x2 - x1;
    dly = y2 - y1;

    %Grid dimension
    NGx = 50;
    NGy = 50;

    % Construct the H matrix
    Hy = zeros(50);
    Hz = zeros(50);
    H = zeros(50);

    global y
    global z
    % Loop computation of the value of H(x, y) in each grid
    for i = 1:NGy

        for j = 1:NGx
            % Calculate the 3 length components of the radius vector r, and r is in the z = 0 plane
            rx = 0 - xc;
            ry = y(j) - yc;
            rz = z(i) - zc;

            % Calculate r cube
            r3 = sqrt(rx.^2 + ry.^2 + rz.^2).^3;

            % Calculate the y, z components of the cross product dl×r, x component is 0
            dlXr_y = dlz .* rx - dlx .* rz;
            dlXr_z = dlx .* ry - dly .* rx;

            % Accumulate the magnetic field intensity created by each segment of the loop.
            Hy(i, j) = sum(C .* dlXr_y ./ r3);
            Hz(i, j) = sum(C .* dlXr_z ./ r3);

            % Calculate the magnitude of H
            H = (Hy.^2 + Hz.^2).^0.5;
        end

    end

end

function magnetic_field_plot(H, Hy, Hz)

    global y
    global z

    % Plot the vector graph of the magnetic field intensity
    figure
    quiver(y(1:5:end, 1:5:end), z(1:5:end, 1:5:end), Hy(1:5:end, 1:5:end), Hz(1:5:end, 1:5:end))
    axis([-3, 3, -3, 3])
    hold on
    % Standard coil section
    plot(1, -1, 'ro', -1, -1, 'ro', 1, 1, 'bo', -1, 1, 'bo')
    % Label the axis
    xlabel('y')
    ylabel('z')

    % Plot the graph of magnetic field intensity
    figure
    mesh(y, z, H)
    axis([-3, 3, -3, 3, 0, 300])
    xlabel('y')
    ylabel('z')
    zlabel('H')

    % Set the radian value of the streamlines
    % theta = [0 50 60 70 80 90 100 110 120 130 180] .* pi / 180;
    a = 1:20:360;
    theta = a .* pi / 180;
    % Set the streamline starting circle’s y coordinate
    ys = 1.1 * cos(theta);
    % Set the streamline starting circle’s z coordinate
    zs = 1.1 * sin(theta);

    % Outwardly plot the magnetic line of force from the starting circle.
    figure
    streamline(y, z, Hy, Hz, ys, zs)
    % Inwardly plot the magnetic line of force from the starting circle.
    streamline(y, z, -Hy, -Hz, ys, zs)
    xlabel('y')
    ylabel('z')
end
