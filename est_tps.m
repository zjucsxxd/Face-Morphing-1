function [a1,ax,ay,w] = est_tps(pts, target_value)
% Initialize
n = size(pts,1);
K = zeros(n,n);
P = zeros(n,3);
% Compute matrices K, P
for i=1:n
    for j=1:n
        r(i,j) = norm(pts(i,:)-pts(j,:));
        if i==j
            K(i,j)=0;
        else
            K(i,j) = r(i,j)^2*log(r(i,j)^2);
        end
    end
end
aones = ones(n,1);
P = [pts aones];
zeros_matrix = zeros(3,3);
lamda=0;
eyes_matrix = eye(n+3,n+3);

% Compute TPS coefficients
tps_matrix = [K P; P' zeros_matrix] + lamda*eyes_matrix;
sol_matrix = tps_matrix\[target_value;0;0;0];
w = sol_matrix(1:n);
ax = sol_matrix(n+1);
ay = sol_matrix(n+2);
a1 = sol_matrix(n+3);


   