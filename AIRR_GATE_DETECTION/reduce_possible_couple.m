function [possible_couple_new,num_possible_couple_new]=reduce_possible_couple(possible_couple,num_possible_couple)
%--------------------------------------------------------
% function that will reduce the number of couple found  by taking those with
% the most number of side points

% Use to reduce the computation time 
%--------------------------------------------------------
n=0;
for i=1:length(possible_couple)-1
    if possible_couple(i,1)==possible_couple(i+1,1)
        if possible_couple(i,3)>possible_couple(i+1,3)
        n=n+1;
        remove(n)=i+1;
        else 
        n=n+1;
        remove(n)=i;
        end
    end
end
if n>1
possible_couple(remove,:)=[];
clear remove

end

[order_possible_couple,ind]=sort(possible_couple(:,2));
n=0;
for i=1:length(possible_couple)-1
    if possible_couple(ind(i),2)==possible_couple(ind(i+1),2)
        if possible_couple(ind(i),3)>possible_couple(ind(i+1),3)
        n=n+1;
        remove(n)=ind(i+1);
        else 
        n=n+1;
        remove(n)=ind(i);
        end
    end
end
if n>1;
possible_couple(remove,:)=[];
end
possible_couple_new=possible_couple;
num_possible_couple_new=length(possible_couple);
end



