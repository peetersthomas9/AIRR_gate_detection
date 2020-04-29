function [up_left_white_x,up_left_white_y,check_up_left,down_left_white_x,down_left_white_y,check_down_left]=find_white_left(left,y_moy,dist,gate_image)
%------------------------------------------------------------------------
% Function that will find if there is white pixels close to the area where
% we must found corners if we have a gate
%------------------------------------------------------------------------
% up_leftt_white_x : x coordinates of the white pixel that may correspond
% to the top left corner
% up_left_white_y : y coordinates of the white pixel that may correspond
% to the top left corner
% check_up_left   : number of white pixel found for up left
% down_left_white_x : x coordinates of the white pixel that may correspond
% to the top left corner
% down_left_white_y : y coordinates of the white pixel that may correspond
% to the top left corner
% check_down_left : number of white pixel found for down left
%------------------------------------------------------------------------
% white left
    check_down_left=0;
    check_up_left=0;
    num_up_left=0;
    num_down_left=0;
    %---------------------------------
    % condition on a
    if left-10>1
        l=left-10;
    else 
        l=1;
    end
    %---------------------------------
    
   
    for a=l:left+10
        
        %Whithe up left
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
            RGB=gate_image(j,a,:);
            if RGB(1)>210
                if RGB(2)>210
                    if RGB(3)>210
                        num_up_left=num_up_left+1;
                        up_left_white_x(num_up_left)=a;
                        up_left_white_y(num_up_left)=j;
                        check_up_left=1;
                    end
                end
            end
        end

        %White down left 
      
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
            RGB=gate_image(j,a,:);
            if RGB(1)>210
                if RGB(2)>210
                    if RGB(3)>210
                        num_down_left=num_down_left+1;
                        down_left_white_x(num_down_left)=a;
                        down_left_white_y(num_down_left)=j;
                        check_down_left=1;
                    end
                end
            end
        end
     

    end
    
    if check_down_left==0;
        down_left_white_x=[];
        down_left_white_y=[];  
    end
    if check_up_left==0;
        up_left_white_x=[];
        up_left_white_y=[];
    end
end