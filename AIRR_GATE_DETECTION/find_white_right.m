function [up_right_white_x,up_right_white_y,check_up_right,down_right_white_x,down_right_white_y,check_down_right]=find_white_right(right,y_moy,dist,gate_image)   
%------------------------------------------------------------------------
% Function that will find if there is white pixels close to the area where
% we must found corners if we have a gate
%------------------------------------------------------------------------
% up_right_white_x : x coordinates of the white pixel that may correspond
% to the top right corner
% up_right_white_y : y coordinates of the white pixel that may correspond
% to the top right corner
% check_up_right   : number of white pixel found for up right
% down_right_white_x : x coordinates of the white pixel that may correspond
% to the top right corner
% down_right_white_y : y coordinates of the white pixel that may correspond
% to the top right corner
% check_down_right : number of white pixel found for down right
%------------------------------------------------------------------------
% white right
    check_down_right=0;
    check_up_right=0;
    num_down_right=0;
    num_up_right=0;
    %---------------------------------
    % condition on b
    if right+10<length(gate_image(1,:,1))
        l=right+10;
    else 
        l=length(gate_image(1,:,1));
    end
    %---------------------------------
    
   
    for b=right-10:l
      
        %Whithe up right
        %--------------------------
        %condition on j 
        if round(y_moy-dist/2)-20>1
            w=round(y_moy-dist/2)-20;
        else
            w=1;
        end
        if round(y_moy)-10>1
            x=round(y_moy)-10;
        else
            x=round(y_moy); 
        end
        %--------------------------
        for j=w:x
            RGB=gate_image(j,b,:);
            if RGB(1)>210
                if RGB(2)>210
                    if RGB(3)>210
                        num_up_right=num_up_right+1;
                        up_right_white_x(num_up_right)=b;
                        up_right_white_y(num_up_right)=j;
                        check_up_right=1;
                    end
                end
            end
        end

        %White down right

         %--------------------------
        %condition on j 
        if round(y_moy+dist/2)+20<length(gate_image(:,1,1))
            w=round(y_moy+dist/2)+20;
        else
            w=length(gate_image(:,1,1));
        end
        if round(y_moy)+10<length(gate_image(:,1,1))
            x=round(y_moy)+10;
        else
            x=round(y_moy); 
        end
        %--------------------------
        for j=x:w
            RGB=gate_image(j,b,:);
            if RGB(1)>210
                if RGB(2)>210
                    if RGB(3)>210
                        num_down_right=num_down_right+1;
                        down_right_white_x(num_down_right)=b;
                        down_right_white_y(num_down_right)=j;
                        check_down_right=1;
                    end
                end
            end
        end

        if check_down_right==0;
            down_right_white_x=[];
            down_right_white_y=[];
        end
        if check_up_right==0;
            up_right_white_x=[];
            up_right_white_y=[];
        end
    end
end