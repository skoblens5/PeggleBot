%% Measure Acceleration and Velocity of Peggle Ball

% Import video
% vidObj = VideoReader("thridtimethecharm.mp4");
% vidObj = VideoReader("bounce_on_black.mp4");
vidObj = VideoReader("falling.mp4");


N = vidObj.NumFrames;

% Background Frame
vidframes = read(vidObj, [1 N]);
bkg = im2gray(vidframes(:,:,:,1));

frames2use = 169:180;
% frames2use = 1:N-3;
n = length(frames2use);
center_track = zeros(n,2);
radius_track = zeros(n,1);

k = 1;
for i = frames2use
    % Load Frame
    frame = im2gray(vidframes(:,:,:,i));

    % Subtract Background
    im = frame;
    [centers, radii] = imfindcircles(im,[3,12],"ObjectPolarity","bright");
    imshow(im)
    hold on
    viscircles(centers,radii)

    if ~isempty(radii)
        center_track(k,:) = centers;
        radius_track(k) = radii;
    end

    k = k + 1;

end

figure;
fps = 30;
time = (1:n)./fps; % time in s
plot(time, center_track(:,2),'.-')
xlabel('time [s]')
ylabel('height [px]')
title('Height vs Time')
set(gcf,'Color','w')
set(gca,'FontSize',12)

[a,b] = polyfit(time,center_track(:,2),2);
hold on
plot(time, time.^2*a(1)+time*a(2)+a(3))