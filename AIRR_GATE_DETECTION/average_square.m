function [x_sqr_DEF,y_sqr_DEF,probability]=average_square(sqr_x,sqr_y,possible_couple,pot_couple)        
%--------------------------------------------------------------------
%function that will compare the different squares. IF the x coordinates of
%different squares are close to each other it must correspond to the same
%square. The final square will be an average of those square
% If there is more than one square with different coordinates. The different squares are kept

% This function is not often call but is usefull when the drone is close to
% the gate. When the drone is close to the gate different side points may
% correspond to the same side of the gate.

% x_sqr_DEF : same as sqr_x but the square that are similar are put
% together to form only one square
% x_sqr_DEF : same as sqr_y but the square that are similar are put
% together to form only one square
%--------------------------------------------------------------------
gg=1;
        div=1;
        [left_side,ind_left]=sort(sqr_x(:,1));
        sum_x=sqr_x(ind_left(1),:);
        sum_y=sqr_y(ind_left(1),:);
        probability(1)=possible_couple(pot_couple(1),3);
        y_sqr_DEF=sqr_y(ind_left(1),:);
        x_sqr_DEF=sqr_x(ind_left(1),:);
        
        for nn=2:length(sqr_x(:,1))
                       
            if abs(x_sqr_DEF(gg,1)-left_side(nn))<30 & abs(x_sqr_DEF(gg,2)-sqr_x(ind_left(nn),2))<30
                sum_x=sum_x+sqr_x(ind_left(nn),:);
                sum_y=sum_y+sqr_y(ind_left(nn),:);
                div=div+1;
                x_sqr_DEF(gg,:)=sum_x/div;
                y_sqr_DEF(gg,:)=sum_y/div;
                probability(gg)=max(probability(gg),possible_couple(pot_couple(nn),3));
            else
                gg=gg+1;
                x_sqr_DEF(gg,:)=sqr_x(ind_left(nn),:);
                y_sqr_DEF(gg,:)=sqr_y(ind_left(nn),:);
                probability(gg)=possible_couple(pot_couple(nn),3);
                sum_x=sqr_x(ind_left(nn),:);
                sum_y=sqr_y(ind_left(nn),:);
                div=1;
            end
        end