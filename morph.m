function morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
%% Initialize
im1 = im2double(im1);
im2 = im2double(im2);
im1 = im2double(im1); im2 = im2double(im2);

% Change the image size to be the bigger size of the two original images
[m1, n1, t1] = size(im1);
[m2, n2, t2] = size(im2); 
m = max(m1,m2);
n = max(n1,n2);
morphed_im1 = ones(m,n,3);
morphed_im2 = ones(m,n,3);
imbig1 = ones(m,n,3);
imbig2 = ones(m,n,3);
for i=1:m1
    for j=1:n1
        imbig1(i,j,:) = im1(i,j,:);
    end
end
for i=1:m2
    for j=1:n2
        imbig2(i,j,:) = im2(i,j,:);
    end
end
im1 = imbig1;
im2 = imbig2;

% Compute the intermediate shape for a given warp_frac
interm_pts = (1-warp_frac) * im1_pts + warp_frac*im2_pts;

[pixelX,pixelY] = meshgrid ([1:n],[1:m]);
pixelX = pixelX(:);
pixelY = pixelY(:);

%% Morphing for the first image
% Find which triangle a pixel is in
T = tsearchn(interm_pts,tri,[pixelX pixelY]);

% Compute the barycentric coordinate for each pixel and do inverse warping
for i=1:m*n
    if isnan(T(i))
        morphed_im1(pixelY(i),pixelX(i),:) = im1(pixelY(i),pixelX(i),:);
    else
        tri_index = tri(T(i),:);
        ax = interm_pts(tri_index(1),1);
        ay = interm_pts(tri_index(1),2);
        bx = interm_pts(tri_index(2),1);
        by = interm_pts(tri_index(2),2);
        cx = interm_pts(tri_index(3),1);
        cy = interm_pts(tri_index(3),2);
        barycentricMatrix = [ax bx cx; ay by cy; 1 1 1];
        bcen = barycentricMatrix \ [pixelX(i) pixelY(i) 1]';
        axs = im1_pts(tri_index(1),1);
        ays = im1_pts(tri_index(1),2);
        bxs = im1_pts(tri_index(2),1);
        bys = im1_pts(tri_index(2),2);
        cxs = im1_pts(tri_index(3),1);
        cys = im1_pts(tri_index(3),2);
        xyz = [axs bxs cxs; ays bys cys; 1 1 1]*bcen;
        xyz = round(xyz/xyz(3));
        morphed_im1(pixelY(i),pixelX(i),:) = im1(xyz(2),xyz(1),:);
    end
end

%% Morphing for the second image
% Compute the barycentric coordinate in the second image for each pixel and do inverse warping
for i=1:m*n
    if isnan(T(i))
        morphed_im2(pixelY(i),pixelX(i),:) = im2(pixelY(i),pixelX(i),:);
    else
        tri_index = tri(T(i),:);
        ax = interm_pts(tri_index(1),1);
        ay = interm_pts(tri_index(1),2);
        bx = interm_pts(tri_index(2),1);
        by = interm_pts(tri_index(2),2);
        cx = interm_pts(tri_index(3),1);
        cy = interm_pts(tri_index(3),2);
        barycentricMatrix = [ax bx cx; ay by cy; 1 1 1];
        bcen = barycentricMatrix \ [pixelX(i) pixelY(i) 1]';
        axs = im2_pts(tri_index(1),1);
        ays = im2_pts(tri_index(1),2);
        bxs = im2_pts(tri_index(2),1);
        bys = im2_pts(tri_index(2),2);
        cxs = im2_pts(tri_index(3),1);
        cys = im2_pts(tri_index(3),2);
        xyz = [axs bxs cxs; ays bys cys; 1 1 1]*bcen;
        xyz = round(xyz/xyz(3));
        morphed_im2(pixelY(i),pixelX(i),:) = im2(xyz(2),xyz(1),:);
    end
end

%% Dissolve the two morphed images
morphed_im = (1-dissolve_frac)*morphed_im1 + dissolve_frac*morphed_im2;

