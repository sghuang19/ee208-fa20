clear

% Set the mass
m = 0.02;
% Set the quantity of charge
q = 1.6e-2;

% Set the timestep to be 0.001s
dt = 0.0001;
% Construct the array of time
t = 0:dt:4;

% Construct the velocity vector
vx = zeros(16, length(t));
vy = vx;
vz = vx;
% Set the velocity vector's initial value.
for k = 0:15
    vx(k + 1, 1) = 0.1 * sin(k * pi / 8);
    vy(k + 1, 1) = 0.1 * cos(k * pi / 8);
end

vz(:, 1) = 10 * ones(16, 1);

% Set the position vector
rx = zeros(16, length(t));
ry = rx;
rz = rx;

% Set the electric field vector
Ex = 0;
Ey = 0;
Ez = 0;

% Set the magnetic flux density vector
Bx = 0;
By = 0;
Bz = 8;

% Construct the force vector；
Fx = zeros(16, length(t));
Fy = Fx;
Fz = Fx;

% Construct the acceleration vector
ax = zeros(16, length(t));
ay = ax;
az = ax;

% Calculate each position point
for i = 1:16

    for j = 1:(length(t) - 1)
        % Calculate the acted force at position j
        Fx(i, j) = q * Ex + q * (vy(i, j) * Bz - vz(i, j) * By);
        Fy(i, j) = q * Ey + q * (vz(i, j) * Bx - vx(i, j) * Bz);
        Fz(i, j) = q * Ez + q * (vx(i, j) * By - vy(i, j) * Bx);

        % Calculate the acceleration at position j
        ax(i, j) = Fx(i, j) / m;
        ay(i, j) = Fy(i, j) / m;
        az(i, j) = Fz(i, j) / m;

        % Calculate the velocity at position j + 1
        vx(i, j + 1) = vx(i, j) + ax(i, j) * dt;
        vy(i, j + 1) = vy(i, j) + ay(i, j) * dt;
        vz(i, j + 1) = vz(i, j) + az(i, j) * dt;

        % Calculate the position at point j + 1
        rx(i, j + 1) = rx(i, j) + vx(i, j) * dt;
        ry(i, j + 1) = ry(i, j) + vy(i, j) * dt;
        rz(i, j + 1) = rz(i, j) + vz(i, j) * dt;
    end

end

figure
% Plot
for i = 1:16
    plot3(rx(i, :), ry(i, :), rz(i, :))
    hold on
end

grid
%  Set the graph’s title
title('The trajectory of charged particals in magnetic field')
%  Label x axis
xlabel('x-axis', 'fontsize', 12)
%  Label y axis
ylabel('y-axis', 'fontsize', 12)
%  Label z axis
zlabel('z-axis', 'fontsize', 12)
