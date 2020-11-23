clear
close all

global k
global rho
global X
global Y
global Veq
global xs
global ys

k = 9e9;
rho = 1e-9;

xm = 5;
ym = 5;
x = linspace(-xm, xm, 50);
y = linspace(-ym, ym, 50);
[X, Y] = meshgrid(x, y);

V = k * rho * log((1 - X + sqrt((1 - X).^2 + Y.^2)) ./ (-1 - X + sqrt((-1 - X).^2 + Y.^2)));

mesh(X, Y, V)
xlabel('x-axis (m)')
ylabel('y-axis (m)')
zlabel('potential')

Vmin = 0;
Vmax = 50;
Veq = linspace(Vmin, Vmax, 50);
figure
contour(X, Y, V, Veq);
xlabel('x-axis (m)')
ylabel('y-axis (m)')
hold on
plot([-1, 1], [0, 0], 'k', 'LineWidth', 3)

del_theta = 10;
theta = (0:del_theta:360) .* pi / 180;
xs = [cos(theta), 0];
ys = [0, sin(theta)];

[Ex, Ey] = gradient(-V);
figure
streamline(X, Y, Ex, Ey, xs, ys)
hold on
plot([-1, 1], [0, 0], 'k', 'LineWidth', 5)
xlabel('x-axis (m)')
ylabel('y-axis (m)')

V20 = segments(20);
V50 = segments(50);
V100 = segments(100);

close all

Vd20 = abs(V - V20);
Vd50 = abs(V - V50);
Vd100 = abs(V - V100);

figure
mesh(X, Y, Vd20)
xlabel('x-axis (m)')
ylabel('y-axis (m)')
zlabel('absolute value of difference')

figure
mesh(X, Y, Vd50)
xlabel('x-axis (m)')
ylabel('y-axis (m)')
zlabel('absolute value of difference')

figure
mesh(X, Y, Vd100)
xlabel('x-axis (m)')
ylabel('y-axis (m)')
zlabel('absolute value of difference')


d20 = sum(sum(Vd20.^2)) / (50 * 50);
d50 = sum(sum(Vd50.^2)) / (50 * 50);
d100 = sum(sum(Vd100.^2)) / (50 * 50);

function V = segments(n)

    global k
    global rho
    global X
    global Y
    global Veq
    global xs
    global ys

    Q = rho * 2 / n;
    d = 2 / n;
    V = zeros(50, 50);

    for index = 1:n
        V = V + k * Q ./ sqrt((X - (-1 + d * index)).^2 + Y.^2);
    end

    figure
    mesh(X, Y, V)
    xlabel('x-axis (m)')
    ylabel('y-axis (m)')
    zlabel('potential')

    figure
    contour(X, Y, V, Veq);
    xlabel('x-axis (m)')
    ylabel('y-axis (m)')
    hold on
    plot([-1, 1], [0, 0], 'k', 'LineWidth', 3)

    [Ex, Ey] = gradient(-V);

    figure
    streamline(X, Y, Ex, Ey, xs, ys)
    hold on
    plot([-1, 1], [0, 0], 'k', 'LineWidth', 5)
    xlabel('x-axis (m)')
    ylabel('y-axis (m)')

end
