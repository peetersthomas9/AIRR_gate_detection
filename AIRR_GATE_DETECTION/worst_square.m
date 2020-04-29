function remove_worst=worst_square(x_1,y_1,x_2,y_2,cc,dd,num_1,num_2)
%-----------------------------------------------------------
% Function that will choose the best square between two squares
%num_1 : probabbility of gate one to be the true gate
%num_2 : probabbility of gate two to be the true gate

%-----------------------------------------------------------

% remove the gate that has the less chance to be a gate
if  num_1>num_2
    remove_worst=dd;
end
if num_2>num_1
    remove_worst=cc;
end

% IF both have the same probability, remove the one with the worst shape 
if num_2==num_1
u_1_up=[x_1(2)-x_1(1),y_1(2)-y_1(1)];
v_1_up=[x_1(2)-x_1(1),0];

u_1_down=[x_1(3)-x_1(4),y_1(4)-y_1(3)];
v_1_down=[x_1(3)-x_1(4),0];

angle_1_up=abs(acos(dot(u_1_up,v_1_up)/(norm(u_1_up)*norm(v_1_up))));

angle_1_down=abs(acos(dot(u_1_down,v_1_down)/(norm(u_1_down)*norm(v_1_down))));

angle_1=angle_1_up+angle_1_down;
% 
%----------------------------------
u_2_up=[x_2(2)-x_2(1),y_2(2)-y_2(1)];
v_2_up=[x_2(2)-x_2(1),0];

u_2_down=[x_2(3)-x_2(4),y_2(4)-y_2(3)];
v_2_down=[x_2(3)-x_2(4),0];

angle_2_up=abs(acos(dot(u_2_up,v_2_up)/(norm(u_2_up)*norm(v_2_up))));

angle_2_down=abs(acos(dot(u_2_down,v_2_down)/(norm(u_2_down)*norm(v_2_down))));

angle_2=angle_2_up+angle_2_down;
%----------------------------------
if angle_2>angle_1
    remove_worst=dd;
else
    remove_worst=cc;
end
end

end


