function morphed_im = morph_tps(im_source, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, ctr_pts, sz)
% a1 x, ax x, ay x, w x are the parameters solved when doing est tps in the x direction.
% a1 y, ax y, ay y, w y are the parameters solved when doing est tps in the y direction.
% ctr_pts are the control points used (the second and third columns of P)
% sz is the desired size for morphed im stored as [rows, cols] when the image sources are of different sizes

% Change the image size to be the bigger size of the two original images
[m,n,t] = size(im_source);
morphed_im = ones(sz(1),sz(2),3);
imbig = ones(sz(1),sz(2),3);
for i=1:m
    for j=1:n
        imbig(i,j,:) = im_source(i,j,:);
    end
end
% Transform the pixels in morphed_im by the TPS model, and read back the
% pixel value in im_source
num_cps = size(ctr_pts,1);
for i=1:sz(1)
    for j=1:sz(2)
        for k=1:num_cps
            r(k) = norm(ctr_pts(k,:)-[j,i]);
            if r(k)==0
                ur(k)=0;
            else
                ur(k) = r(k)^2*log(r(k)^2);
            end
        end
        sumur_x = sum(w_x.*ur');
        xx = a1_x + ax_x*j + ay_x*i + sumur_x;
        xx = round(xx);
        sumur_y = sum(w_y.*ur');
        yy = a1_y + ax_y*j + ay_y*i + sumur_y;
        yy = round(yy);
        if yy<=0
            yy=1;
        elseif yy>sz(1)
            yy=sz(1);
        end
        % Deal with the pixels transformed outside of the image
        if xx<=0
            xx=1;
        elseif xx>sz(2)
            xx=sz(2);
        end
        % Read back the pixel value
        morphed_im(i,j,:) = imbig(yy,xx,:);
    end
end