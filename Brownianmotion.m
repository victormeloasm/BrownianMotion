N = 1000;
x = cumsum(randn(1, N));
y = cumsum(randn(1, N));
z = cumsum(randn(1, N));

h = figure;
set(h, 'Position', [0, 0, 1920, 1080]); % Set figure size for 1080p resolution
view(3);
set(gca, 'GridLineStyle', '--')
hold on;
axis tight manual;
xlabel('x');
ylabel('y');
zlabel('z');

r0 = [x(1) y(1) z(1)];
rf = [x(end) y(end) z(end)];

plot3(x, y, z, 'LineWidth', 1.5);
plot3(r0(1), r0(2), r0(3), 'or', 'MarkerFaceColor', 'r');
plot3(rf(1), rf(2), rf(3), 'ok', 'MarkerFaceColor', 'k');

d = sqrt(sum((rf - r0).^2));
Information = strcat('Three-dimensional Brownian Motion, d=', num2str(d), ' units');
title(Information, 'FontWeight', 'bold');
view(-109, 58);

% Animation settings
fps = 30; % Adjust the frame rate as needed
frameDuration = 1 / fps;
numFrames = numel(x);

% Close the initial figure
close(h);

% Create a new figure for animation
h_anim = figure;
set(h_anim, 'Position', [0, 0, 1920, 1080]); % Set figure size for 1080p resolution

% Create a VideoWriter object with width and height parameters
outputVideo = VideoWriter('animation.mp4', 'MPEG-4');
outputVideo.FrameRate = fps;
outputVideo.Quality = 100; % Adjust the quality (1-100) as needed
open(outputVideo);

for frame = 1:numFrames
    cla;
    hold on;
    plot3(x(1:frame), y(1:frame), z(1:frame), 'LineWidth', 1.5);
    plot3(r0(1), r0(2), r0(3), 'or', 'MarkerFaceColor', 'r');
    plot3(rf(1), rf(2), rf(3), 'ok', 'MarkerFaceColor', 'k');
    title(Information, 'FontWeight', 'bold');
    view(-109, 58);
    drawnow;
    
    % Write current frame to the video file
    frameImage = getframe(h_anim);
    writeVideo(outputVideo, frameImage.cdata);
    
    % Delay between frames to achieve desired frame rate
    pause(frameDuration);
end

% Prompt the user to close the figure manually
disp('Animation finished. Close the figure window to exit.');
uiwait(h_anim);

% Close the animation figure
close(h_anim);

% Close the VideoWriter object
close(outputVideo);

disp('MP4 video saved successfully.');
