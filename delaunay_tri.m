function tri = delaunay_tri(im1_pts, im2_pts)

% Compute the control points at the midway shape
num_pts = length(im1_pts);
mean_pts = zeros(num_pts,2);
mean_pts(:,1) = (im1_pts(:,1) + im2_pts(:,1))/2;
mean_pts(:,2) = (im1_pts(:,2) + im2_pts(:,2))/2;

% Compute the triangulation at the midway shape
tri = delaunay(mean_pts(:,1),mean_pts(:,2));





