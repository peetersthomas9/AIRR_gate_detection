% Apply SIFT FEATURES
function [gate_1_x,gate_1_y,gate_check]=sift_features(x_pre,y_pre,image_pre,image_now,Border_x,Border_y)
%---------------------------------------------------------------
% function that will use SIFT feautres to calculate the transformation
% between the previous and the actual image. This transformation will after
% be applied to the previous square to find the position of the new square.
% If the new square found is not too much deformed, we keep it and
% consider it as the gate_1 on this image.
%---------------------------------------------------------------
vl_setup
[f_pre d_pre] = vl_sift(single(rgb2gray(image_pre))); % keypoint and descriptor of the image
[f_now d_now] = vl_sift(single(rgb2gray(image_now))); %

threshold = 2.5; % Threshold  
[matches, scores] = vl_ubcmatch(d_pre, d_now, threshold) ; %Computing the reliable matches

% FIND THE TRANSFORMATION

% https://fr.wikipedia.org/wiki/Scale-invariant_feature_transform


for k=1:length(matches(1,:))
    % Matrice A
    A(2*k-1,1)=f_pre(1,matches(1,k));
    A(2*k-1,2)=f_pre(2,matches(1,k));
    A(2*k,3)=f_pre(1,matches(1,k));
    A(2*k,4)=f_pre(2,matches(1,k));
    A(2*k-1,3:4)=0;
    A(2*k-1,5)=1;
    A(2*k-1,6)=0;
    A(2*k,1:2)=0;
    A(2*k,5)=0;
    A(2*k,6)=1;
    
    %Matrice b
    b(2*k-1)=f_now(1,matches(2,k));
    b(2*k)=f_now(2,matches(2,k));
end
% the 4 first value of x_ap correspond to the rotational matrix
% the 2 last values of x_ap corresponf to the translational vector 
x_ap=inv(A.'*A)*A.'*b.';


R=[x_ap(1),x_ap(2);x_ap(3),x_ap(4)];
t=[x_ap(5);x_ap(6)];
x_old=x_pre;
y_old=y_pre;
gate_1=R*[x_old;y_old]+t;
gate_1_x=gate_1(1,:);
gate_1_y=gate_1(2,:);



% CHECK IF RESULT CAN BE CONSIDER AS GOOD RESULT: if it is close to a
% square
if abs(gate_1_x(1)-gate_1_x(4))<10 & abs(gate_1_x(3)-gate_1_x(2))<10 & abs(gate_1_y(1)-gate_1_y(2))<10 & abs(gate_1_y(3)-gate_1_y(4))<10
    gate_check=1;
else 
    gate_check=0;
end


end