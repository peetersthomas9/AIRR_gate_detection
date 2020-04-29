%% find spf

function [spf_x,spf_y,num_spf]=find_spf(side_point_x,side_point_y)
%------------------------------------------------
% Function that will replace side_point_x and side_point_y with fewer points 
% Those new points will be at the center of the zone where a large number
% of points (side_point_x and side_point_y) where found 
%------------------------------------------------

%spf_x : [1*N] x coordinates of the reduced number of points corresponding to
%the side of the gate

%spf_y : [1*N] y coordinates of the reduced number of points corresponding to
%the side of the gate

%num_spf :[1*N] Number of points side_point close to a point spf

%side_point_x : [1*M] x coordinates of the center points of areas that are
%susceptible to be the side of the gate

%side_point_y : [1*M] y coordinates of the center points of areas that are
%susceptible to be the side of the gate
%-----------------------------------------------
% remove points at the top of the image as they correspond to the ceiling
rem=0;
for i=1:length(side_point_y)
    if side_point_y(i)<100
        rem=rem+1;
        remove(rem)=i;
    end 

end
if rem>0
side_point_x(remove)=[];
side_point_y(remove)=[];

clear remove

end




%------------------------------------------
%Average value of the y coordinate of the side_point in the same column
[side_point_x_sort,indice]=sort(side_point_x);
num=1;
sum_moy_col_x(1)=side_point_x_sort(1);
sum_moy_col_y(1)=side_point_y(indice(1));
num_col=1;
for i=2:length(side_point_x_sort)-1
    if side_point_x_sort(i)==side_point_x_sort(i+1)
        num_col=1+num_col;
        sum_moy_col_y(num)=sum_moy_col_y(num)+side_point_y(indice(i+1));
        sum_moy_col_x(num)=side_point_x_sort(i+1);
        if i==length(side_point_x_sort)-1
            moy_col_y(num)=round(sum_moy_col_y(num)/num_col);
            moy_col_x(num)=sum_moy_col_x(num);
        end
    else

        moy_col_y(num)=round(sum_moy_col_y(num)/num_col);
        moy_col_x(num)=sum_moy_col_x(num);
        num_col=1;
        num=num+1;
        sum_moy_col_y(num)=side_point_y(indice(i+1));
        sum_moy_col_x(num)=side_point_x_sort(i+1);
    end
end
clear indice


%-------------------------------------------------------------
%Remove the average column points if there is no other average column
%point close to it in a window of 20*20 around it 

T=zeros(max(moy_col_y)+15,max(moy_col_x)+15);
for i=1:length(moy_col_y)
    T(moy_col_y(i),moy_col_x(i))=1;
end
U=zeros(max(side_point_y)+15,max(side_point_x)+15);
for i=1:length(side_point_y)
    U(side_point_y(i),side_point_x(i))=1;
end

num=0;
for i=1:length(moy_col_x)-1
    sum=0;
    if length(T(1,:,1))-15>moy_col_x(i) & moy_col_x(i)>15 & length(T(:,1,1))-15>moy_col_y(i) & moy_col_y(i)>15
        for a=-10:10
            for b=-10:10
                                
                if T(moy_col_y(i)+a,moy_col_x(i)+b)==1
                    sum=sum+1;
                end
            end
        end
    
    if sum<=1
        sum_2=length(find(U(:,moy_col_x(i))));
        if sum_2<=2
        num=num+1;
        remove_indice(num)=i;
        end
    end
    end
end
if num>0
moy_col_x(remove_indice)=[];
moy_col_y(remove_indice)=[];
end


%-------------------------------------------------------------------------
%Put together the moy_col that are close together to form only one possible
%coordinate for the sides of the gate
thres_x=moy_col_x(1);
thres_y=moy_col_y(1);
num=1;
spf_x(num)=thres_x;
spf_y(num)=thres_y;
c=1;


for i=2:length(moy_col_x)
    
    if moy_col_x(i)>thres_x+23 | abs(moy_col_y(i)-thres_y)>23 
        num=num+1;
        thres_x=moy_col_x(i);
        thres_y=moy_col_y(i);
        spf_x(num)=round(thres_x);
        spf_y(num)=round(thres_y);
        c=1;
        if i==length(moy_col_x)
            spf_x(num)=round(thres_x);
            spf_y(num)=round(thres_y);
        end
    else
        c=c+1;
        thres_x=thres_x+(moy_col_x(i)-thres_x)/(c);
        thres_y=thres_y+(moy_col_y(i)-thres_y)/(c);
        
        spf_x(num)=round(thres_x);
        spf_y(num)=round(thres_y);
    end 
end  
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%Will calculate the number of points side_point that are close to the point
%spf. If more points are found, the probability of this point spf to be a
%side of the gate is higher
for i=1:length(spf_x)
    %------------------------
    %Condition
    if spf_x(i)>8
        if spf_x(i)<length(U(1,:))-8
            l=spf_x(i)-8;
            r=spf_x(i)+8;
        else
            r=length(U(1,:));
            l=length(U(1,:))-16;
        end
    else
        l=1;
        r=17;
    end
    
    if spf_y(i)>25
        if spf_y(i)<length(U(:,1))-25
            u=spf_y(i)-25;
            d=spf_y(i)+25;
        else
            u=length(U(:,1))-50;
            d=length(U(:,1));
        end
    else
        u=1;
        d=51;
    end
    %-----------------------
    num_spf(i)=length(find(U(u:d,l:r)));
end