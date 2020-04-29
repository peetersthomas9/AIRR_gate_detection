function [x_reshape,y_reshape]=reshape_gate(x,y,Image)
% ----------------------------------------------
%function that will replace the gate found with a square. This square will
%be reduce so that we make sure that tha gate found is not larger that the
%real gate.
% ----------------------------------------------
up=round((y(1)+y(2))/2);
down=round((y(3)+y(4))/2);
left=round((x(1)+x(4))/2);
right=round((x(2)+x(3))/2);
dist=right-left;
middle_x=round((right-left)/2+left);
middle_y=round((down-up)/2+up);

% the reduction depends on the size of the gate
x_reshape([1 4 5])=left+dist/8;
x_reshape([2 3])=right-dist/8;

y_reshape([1 2 5])=up+dist/8;
y_reshape([3 4])=down-dist/8;
end



    