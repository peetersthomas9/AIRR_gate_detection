function [possible_couple,num_possible_couple]=find_possible_couple(spf_x,spf_y,num_spf)
%--------------------------------------------------------------------
% function that will compare the different spf to find different couples
% that may be th eleft side and right side of the gate 

%--------------------------------------------------------------------
% possible_couple : [num_possible_couple*3]  the two first values are the two
% indice of the side_reduced that form the couple and the third component
% is the number of side points of each couple
%--------------------------------------------------------------------
possible_couple=[];
num_possible_couple=0;
prop_up=0;
prop_down=0;

for i=1:length(spf_x)-1
    for j=i+1:length(spf_x)
        %---------------------------------------------------------      
        % the difference of the y coordinates of the two must be small
        if abs(spf_y(i)-spf_y(j))<40
            % the distance between the spf couple must be large enough
            if abs(spf_x(i)-spf_x(j))>40
        %---------------------------------------------------------
            num_possible_couple=num_possible_couple+1;
            possible_couple(num_possible_couple,:)=[i,j,num_spf(i)+num_spf(j)];
            end
        end   
    end
end
end
