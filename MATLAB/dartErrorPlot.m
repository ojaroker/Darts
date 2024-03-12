% Define polar coordinates in degrees
[R, Theta] = meshgrid(0:.2:20, -180:180);

% Transform polar coordinates to Cartesian
X = R .* cosd(Theta);
Y = R .* sind(Theta);

% Parameters when difficulty = 50
u1 = 0;
u2 = 0;
s1 = 7.7; %std of radius
s2 = 9.9; %std of theta

% Get normal distribution values
Z = 1/(2*pi*s1*s2) * exp(-0.5*((X-u1).^2 / s1^2 + (Y-u2).^2 / s2^2));

% Plot
figure(1)
contourf(X, Y, Z, 30)
xlabel('Error in Radius (mm)')
ylabel('Error in Theta (degrees)')
title('Probability Density Contour Plot above Center of T20, diff=50')
xlim([-15 15])
ylim([-20 20])
hold on

% Plot boundaries
plot([-4 -4], [-9 9], 'k--', 'LineWidth', 1.5)  % Left boundary (radius = -4)
plot([4 4], [-9 9], 'k--', 'LineWidth', 1.5)    % Right boundary (radius = 4)
plot([-4 4], [9 9], 'k--', 'LineWidth', 1.5)    % Upper boundary (theta = 9)
plot([-4 4], [-9 -9], 'k--', 'LineWidth', 1.5)  % Lower boundary (theta = -9)
hold off