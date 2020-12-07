clear
close all

a = 1; %Input the radius of the current loop
I = 100; %Input the current value in the current loop
C = I / (4 * pi); %Merge the constants
N = 50; %Set the number of division
ym = 3; %Set the range of y direction in the field domain
zm = 3; %Set the range of z direction in the field domain
y = linspace(-ym, ym, 20); % Equally divide y axis into 20 parts
z = linspace(-zm, zm, 20); % Equally divide z axis into 20 parts
theta0 = linspace(0, 2 * pi, N + 1); %Division of the angle of circumference
theta1 = theta0(1:N);
x1 = a * cos(theta1); y1 = a * sin(theta1); %The start point coordinate of each segment of the loop
theta2 = theta0(2:N + 1);
x2 = a * cos(theta2); y2 = a * sin(theta2); %The ending point coordinate of each segment of the loop
zc = 0; xc = (x2 + x1) ./ 2; yc = (y2 + y1) ./ 2; %Calculate the 3 coordinate components of the midpoint of
%each segment of the loop.
dlz = 0; dlx = x2 - x1; dly = y2 - y1; %Calculate the 3 length components of each segment
%vector dl.
NGx = 20; NGy = 20; %Grid dimension
Hy = zeros(20); Hz = zeros(20); H = zeros(20); %Construct the H matrix

for i = 1:NGy%Loop computation of the value of H(x,y) in each grid

    for j = 1:NGx
        rx = 0 - xc; ry = y(j) - yc; rz = z(i) - zc; %Calculate the 3 length components of the radius vector r,
        % and r is in the z = 0 plane.
        r3 = sqrt(rx.^2 + ry.^2 + rz.^2).^3; %Calculate r cube
        dlXr_y = dlz .* rx - dlx .* rz; %Calculate the y, z components of the cross product dl×r,
        %x component is 0.
        dlXr_z = dlx .* ry - dly .* rx;
        Hy(i, j) = sum(C .* dlXr_y ./ r3); %Accumulate the magnetic field intensity created
        %by each segment of the loop.
        Hz(i, j) = sum(C .* dlXr_z ./ r3);
        H = (Hy.^2 + Hz.^2).^0.5; %Calculate the magnitude of H
    end

end

subplot(1, 3, 1), quiver(y, z, Hy, Hz); %Plot the vector graph of the magnetic field intensity
hold on
axis([-3, 3, -3, 3]);
plot(1, 0, 'ro', -1, 0, 'bo'), %Standard coil section
xlabel('y'), ylabel('z'), %Label the axis
subplot(1, 3, 2), mesh(y, z, H); %Plot the graph of magnetic field intensity
axis([-3, 3, -3, 3, 0, 100])
xlabel('y'), ylabel('z'), zlabel('H');
theta = [0 50 60 70 80 90 100 110 120 130 180] .* pi / 180; %Set the radian value of the streamlines
ys = 1.1 * cos(theta); %Set the streamline starting circle’s y coordinate
zs = 1.1 * sin(theta); %Set the streamline starting circle’s z coordinate
subplot(1, 3, 3), streamline(y, z, Hy, Hz, ys, zs); %Outwardly plot the magnetic line of force from the starting%circle.
streamline(y, z, -Hy, -Hz, ys, zs); %Inwardly plot the magnetic line of force from the starting%circle.
xlabel('y'), ylabel('z');
