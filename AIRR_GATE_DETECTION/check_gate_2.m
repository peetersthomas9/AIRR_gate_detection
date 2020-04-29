function [check]=check_gate_2(gate_1_x,gate_1_y,x_2,y_2)
%-------------------------------------------------
%Function that check if the second gate found correspond to a gate or is a
%false positive
% check : equal 1 if the gate detect is assumed as a true positive and 0 if
% it is assumed as a false positive 
%--------------------------------------------------
check=0;
% To make sure that the same side of a gate is not use for the detection of
% 2 gate 
 if abs(x_2(1)-gate_1_x(1))>10 & abs(x_2(2)-gate_1_x(2))>10
     % as the gate are all on the floor, the y coordinates of the second
     % gate must be between the y coordinates of the first gate. 
     if y_2(1)-5>gate_1_y(1) & y_2(2)-5>gate_1_y(2) & y_2(3)+10<gate_1_y(3) & y_2(4)+10<gate_1_y(4)
         check=1;
     end
 end
 
end