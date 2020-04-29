function [x_filter,y_filter,num_d_l]=filter_white(x,y)
%-------------------------------------------
% Function that will put together the average value of the zone where we
% found white pixel. Those new value will be our candidates for the corners
%------------------------------------------
% x : x coordinates of the white pixels
% y : y coordinates of the white pixels

% x_filter : x coordinates of the candidate for the corner of the gate
% y_filter : y coordinates of the candidate for the corner of the gate
% num_d_l :  number of candidate found

%------------------------------------------
        [order_y,ind]=sort(y);
%Average value of the x coordinate of the side_point in the same line        
        sum_moy_raw_y(1)=order_y(1);
        sum_moy_raw_x(1)=x(ind(1));
        num=1;
        num_raw=1;
        num_d_l=1;
        if length(order_y)>=3
            for i_d_l=2:length(order_y)-1
                if order_y(i_d_l)==order_y(i_d_l+1)
                    num_raw=1+num_raw;
                    sum_moy_raw_x(num)=sum_moy_raw_x(num)+x(ind(i_d_l+1));
                    sum_moy_raw_y(num)=order_y(i_d_l+1);
                    if i_d_l==length(order_y)-1
                        moy_raw_x(num)=round(sum_moy_raw_x(num)/num_raw);
                        moy_raw_y(num)=sum_moy_raw_y(num);
                    end
                        
                else
                    moy_raw_x(num)=round(sum_moy_raw_x(num)/num_raw);
                    moy_raw_y(num)=sum_moy_raw_y(num);
                    num_raw=1;
                    num=num+1;
                    sum_moy_raw_x(num)=x(ind(i_d_l+1));
                    sum_moy_raw_y(num)=order_y(i_d_l+1);
                end
            end
            if length(moy_raw_x)>=2
                c=1;
                %Put together the moy_raw that are close together to form only one possible
                %coordinate for the corners of the gate
                thres_x=moy_raw_x(1);
                thres_y=moy_raw_y(1);
                for ii=2:length(moy_raw_x)
                    if moy_raw_y(ii)>thres_y+12 | abs(moy_raw_x(ii)-thres_x)>15
                        num_d_l=num_d_l+1;
                        thres_x=moy_raw_x(ii);
                        thres_y=moy_raw_y(ii);
                        c=1;
                        if ii==length(moy_raw_x)
                            x_filter(num_d_l)=round(thres_x);
                            y_filter(num_d_l)=round(thres_y);
                        end
                    else
                        c=c+1;
                        thres_x=thres_x+(moy_raw_x(ii)-thres_x)/(c);
                        thres_y=thres_y+(moy_raw_y(ii)-thres_y)/(c);
                        x_filter(num_d_l)=round(thres_x);
                        y_filter(num_d_l)=round(thres_y);
                    end
                end
            else
            x_filter=[];
            y_filter=[];
            num_d_l=[];
            end
        else
            x_filter=[];
            y_filter=[];
            num_d_l=[];
        end

end