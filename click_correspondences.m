function [ im1_pts, im2_pts] = click_correspondences(im1, im2)
% Select correspondence control points on image1 and image2. When finishing
% selecting, export control points to the workspace
cpselect('image1.png','image2.png');
