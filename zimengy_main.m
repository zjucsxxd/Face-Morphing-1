%%% ZIMENGY_MAIN.M Morphing animation of my face into another person's face
%% INITIALIZE
do_trig = 1;

% image1 = imread('image1.png');
% image2 = imread('image2.png');
% image1 = im2double(image1); image2 = im2double(image2);
% m1 = size(image1,1); n1 = size(image1,2);
% m2 = size(image2,1); n2 = size(image2,2);
% m = max(m1,m2);
% n = max(n1,n2);
% im1 = ones(m,n,3);
% for i=1:m1
%     for j=1:n1
%         im1(i,j,:)=image1(i,j,:);
%     end
% end
% im2 = ones(m,n,3);
% for i=1:m2
%     for j=1:n2
%         im2(i,j,:)=image2(i,j,:);
%     end
% end
im1 = imread('image1.png');
im2 = imread('image2.png');
im1 = im2double(im1); im2 = im2double(im2);


% Control points
load control_points

p1 = input_points;
p2 = base_points;
tri = delaunay_tri(p1,p2);

% Figure 
h = figure(2); clf;
whitebg(h,[0 0 0]);

%% EVAL
if (do_trig)
  h_avi = avifile('zimengy_trig.avi','fps',10);
else
  h_avi = avifile('zimengy_tps.avi','fps',10);
end

% Morph iteration
for w=0:0.0167:1
    if (do_trig == 0)
      img_morphed = morph_tps_wrapper(im1, im2, p1, p2, w, w);
    else
      img_morphed = morph(im1, im2, p1, p2, tri, w, w);
    end
    % if image type is double, modify the following line accordingly if necessary
    imagesc(img_morphed);
    axis image; axis off;drawnow;
    h_avi = addframe(h_avi, getframe(gcf));
end

h_avi = close(h_avi); clear h_avi;

