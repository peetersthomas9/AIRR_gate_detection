function [sqr_x_good,sqr_y_good,pot_couple_good]=remove_bad_squares(possible_couple,pot_couple,bb,sqr_x,sqr_y)
%----------------------------------------------------------------------------
%Function that will compare the different squares together, if a side
%point is use for two different gates (e.g. the left side of one gate and
%the right side of an other gate), it will remove those with the less
%side_points number (the one with the less probability to be the correct
%gate)
%sqr_x_good : x coordinates of the squares that we keep
%sqr_y_good : y coordinates of the squares that we keep
% pot_couple_good : couple corresponding to the good square
%------------------------------------------------------------------------------
ff=0;

for cc=1:bb-1
    for dd=cc+1:bb
        % if one of the spf is used to detect two different gate, one is
        % removed 
        if possible_couple(pot_couple(cc),1)==possible_couple(pot_couple(dd),1) | possible_couple(pot_couple(cc),1)==possible_couple(pot_couple(dd),2) | possible_couple(pot_couple(cc),2)==possible_couple(pot_couple(dd),1) | possible_couple(pot_couple(cc),2)==possible_couple(pot_couple(dd),2)
            ff=ff+1;
            [remove_worst(ff)]=worst_square(sqr_x(cc,:),sqr_y(cc,:),sqr_x(dd,:),sqr_y(dd,:),cc,dd,possible_couple(pot_couple(cc),3),possible_couple(pot_couple(dd),3));
            
        end
    end
end

if ff>0
    sqr_x(remove_worst,:)=[];
    sqr_y(remove_worst,:)=[];
    pot_couple(remove_worst)=[];
end
clear remove_worst
% redo the same operation once again to be sure that all the different
% square are compared. 
if length(sqr_x(:,1))>=2
    ff=0;
    for cc=1:length(sqr_x(:,1))-1
        for dd=cc+1:length(sqr_x(:,1))
            
            if possible_couple(pot_couple(cc),1)==possible_couple(pot_couple(dd),1) | possible_couple(pot_couple(cc),1)==possible_couple(pot_couple(dd),2) | possible_couple(pot_couple(cc),2)==possible_couple(pot_couple(dd),1) | possible_couple(pot_couple(cc),2)==possible_couple(pot_couple(dd),2)
                ff=ff+1;
                remove_worst(ff)=worst_square(sqr_x(cc,:),sqr_y(cc,:),sqr_x(dd,:),sqr_y(dd,:),cc,dd,possible_couple(pot_couple(cc),3),possible_couple(pot_couple(dd),3));
                
            end
        end
    end
    
    if ff>0
        sqr_x(remove_worst,:)=[];
        sqr_y(remove_worst,:)=[];
        pot_couple(remove_worst)=[];
    end
end
sqr_x_good=sqr_x;
sqr_y_good=sqr_y;
pot_couple_good=pot_couple;
end
