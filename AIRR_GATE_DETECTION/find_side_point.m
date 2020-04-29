function [side_point_x,side_point_y,num_side_point]=find_side_point(gate_image)
% -----------------------------------------------------------
% function will calculate the mean intensity of a window of 30*5.
% If this mean intensity is between specific value it may be considered as
% a possible area of the side of the gate. 
%side_point_x and side_point_y are respectively the x and y coordinates of the center points of those areas in
%the image
%-------------------------------------------------------------
%side_point_x : [M*1] x coordinates of the center points of areas that are
%susceptible to be the side of the gate

%side_point_y : [M*1] y coordinates of the center points of areas that are
%susceptible to be the side of the gate

% gate_image : Image 
%-------------------------------------------------------------
hau=30; %width of the window
lon=5; %height of the window

d=3; % pixel displacement in x or y between each window 


m=round(length(gate_image(:,1,1))/d-hau/d)-1;
n=round(length(gate_image(1,:,1))/d-lon/d)-1;
side_point_x=[];
side_point_y=[];
num_side_point=0; % number of area found

for j=1:m
    for i=1:n
        RGB=mean(mean(gate_image(1+(j-1)*d:hau+1+(j-1)*d,1+(i-1)*d:lon+1+d*(i-1),:)));
        R=RGB(1);
        G=RGB(2);
        B=RGB(3);
        %-------------------------------------------------
        % Values found by checking the intensity at the center of the left
        % side and right side of the gate in different images with
        % different intensities
        
        if R>35 & R<90
            if G>90 & G<195
                if B>150 & B<250
         %-------------------------------------------------
                    num_side_point=num_side_point+1;
                    side_point_x(num_side_point)=1+(i-1)*d+round(lon/2);
                    side_point_y(num_side_point)=1+(j-1)*d+round(hau/2)-3;

                end
            end
        end
    end
end