function morphed_im = morph_tps_wrapper(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)

% Compute the intermediate shape for a given warp_frac
interm_pts = (1-warp_frac) * im1_pts + warp_frac*im2_pts;
% Compute the size of the morphed image
im1 = im2double(im1); im2 = im2double(im2);
[m1, n1, t1] = size(im1);
[m2, n2, t2] = size(im2); 
m = max(m1,m2);
n = max(n1,n2);

% Compute a set of coefficient for x, and another set for y. Do image
% morphing for the first image
[a1_x1,ax_x1,ay_x1,w_x1] = est_tps(interm_pts, im1_pts(:,1));
[a1_y1,ax_y1,ay_y1,w_y1] = est_tps(interm_pts, im1_pts(:,2));
morphed_im1 = morph_tps(im1, a1_x1, ax_x1, ay_x1, w_x1, a1_y1, ax_y1, ay_y1, w_y1, interm_pts, [m,n]);

% Compute a set of coefficient for x, and another set for y. Do image
% morphing for the second image
[a1_x2,ax_x2,ay_x2,w_x2] = est_tps(interm_pts, im2_pts(:,1));
[a1_y2,ax_y2,ay_y2,w_y2] = est_tps(interm_pts, im2_pts(:,2));
morphed_im2 = morph_tps(im2, a1_x2, ax_x2, ay_x2, w_x2, a1_y2, ax_y2, ay_y2, w_y2, interm_pts, [m,n]);

%% Dissolve the two morphed images
morphed_im = (1-dissolve_frac)*morphed_im1 + dissolve_frac*morphed_im2;
