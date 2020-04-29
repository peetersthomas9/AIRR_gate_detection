%% Final Algorithm 

% Detection gate algorithm based on pixel detection and SIFT features. 
% the algorithm first try to find the gates by studiying the pixel
% intensity. If no gate is found we use SIFT features method.
 

%% Load the images


WashingtonOBRace_files = dir('WashingtonOBRace');
img_files=WashingtonOBRace_files(4:311); % Image that we want to analyse 



%% LOOP FOR TO FIND GATE ON A SPECIFIC NUMBER OF IMAGE

show_gate=1;    %show_gate=1 will show the image and the gates detected
t=0;            % variable that will change at each iteration of the loop for (usefull if we start the loop at an other number than 1
gate=[];        % structure that will give us all the information on the gates found

tic
                % r : images that we want to study
for r=1:10 %numel(img_files)
    gate_image=imread(['WashingtonOBRace/',img_files(r).name]); %read the image
    %% FIND POTENTIAL CANDIDATE FOR LEFT SIDE AND RIGHT SIDE OF THE GATE
    
    [side_point_x,side_point_y,num_Border]=find_side_point(gate_image);
  
    if num_Border>4
        % filter side_point to keep only the important data found 
        [spf_x,spf_y,num_spf]=find_spf(side_point_x,side_point_y);
        

        
        %% FIND COUPLE THAT MAY CORRESPOND TO THE LEFT AND RIGHT SIDE OF THE GATE
        if length(spf_x)>=2
            [possible_couple,num_possible_couple]=find_possible_couple(spf_x,spf_y,num_spf);
            % reduce the number of couple found if there is too many
            % (reduce the computation time of the algorithm)
            if num_possible_couple>8
                [possible_couple_new,num_possible_couple]=reduce_possible_couple(possible_couple,num_possible_couple);
                clear possible_couple
                possible_couple=possible_couple_new;               
            end
         
 
            %-------------------------------------------------------------
            if num_possible_couple>=1  % IF WE HAVE A POSSIBLE COUPLE
                
                
                
                bb=0;
                for i=1:length(possible_couple(:,1))
                    
                    dist=round(abs(spf_x(possible_couple(i,1))-spf_x(possible_couple(i,2))));    %distance between the left and right side 
                    y_moy=((spf_y(possible_couple(i,1))+spf_y(possible_couple(i,2)))/2);         %y coordinate of the middle of the potential gate 
                    left=min([spf_x(possible_couple(i,1)),spf_x(possible_couple(i,2))]);         %coordinate of the center of the left side
                    right=max([spf_x(possible_couple(i,1)),spf_x(possible_couple(i,2))]);        %coordinate of the center of the right side
                    
%% FIND CORNERS OF THE GATES

                    % find white pixel above and under the point left and
                    % right (use to detect the corner as they are composed
                    % of white and blue square)
                    [up_left_white_x,up_left_white_y,check_up_left,down_left_white_x,down_left_white_y,check_down_left]=find_white_left(left,y_moy,dist,gate_image);
                    
                    
                    [up_right_white_x,up_right_white_y,check_up_right,down_right_white_x,down_right_white_y,check_down_right]=find_white_right(right,y_moy,dist,gate_image);
                    %------------------------------------------------------------------
                    % If we detect white pixel for each potential corners
                    if check_down_left~=0 && check_up_left~=0 && check_down_right~=0 && check_up_right~=0
                        
                        %--------------------------------------------------------------
                        % filter the point found on each corner to keep
                        % only the important datas 
                                % FILTER DOWN_LEFT
 
                        [spf_x_d_l,spf_y_d_l,num_d_l]=filter_white(down_left_white_x,down_left_white_y);

                                % FILTER UP_LEFT
                        [spf_x_u_l,spf_y_u_l,num_u_l]=filter_white(up_left_white_x,up_left_white_y);
                                                       
                                % FILTER UP_RIGHT
                        [spf_x_u_r,spf_y_u_r,num_u_r]=filter_white(up_right_white_x,up_right_white_y);
                        
                                % FILTER DOWN_RIGHT
                        [spf_x_d_r,spf_y_d_r,num_d_r]=filter_white(down_right_white_x,down_right_white_y);
                        
                        %-----------------------------------------------------------------
                        
                        if num_d_l>=1 && num_d_r>=1 && num_u_r>=1 && num_u_l>=1
                            

  %% TRY TO FIND A GATE FOR THIS COUPLE AND THOSE CORNERS                          
                            [square_final_x,square_final_y,var]=find_squares(spf_x_u_l,spf_y_u_l,spf_x_u_r,spf_y_u_r,spf_x_d_r,spf_y_d_r,spf_x_d_l,spf_y_d_l,dist,gate_image);
                            
                            % ADD  all the possible square are kept in the
                            % matric sqr_x and sqr_y
                            if var>0
                                bb=bb+1;
                                sqr_x(bb,:)=square_final_x; %x coordinates of the square
                                sqr_y(bb,:)=square_final_y; %y coordinates of the square
                                pot_couple(bb)=i;           % couple corresponding to the square found 
                            end
                            %-----------------------------------------------------------------
                            
                            
                            
                            
                            
                        end
                    end
                    clear spf_x_d_l
                    clear spf_x_d_r
                    clear spf_x_u_l
                    clear spf_x_u_r
                    clear spf_y_d_l
                    clear spf_y_d_r
                    clear spf_y_u_l
                    clear spf_y_u_r
                    clear up_left_white_x
                    clear up_left_white_y
                    clear down_left_white_x
                    clear down_left_white_y
                    clear up_right_white_x
                    clear up_right_white_y
                    clear down_right_white_x
                    clear down_right_white_y
                    clear square_final_x
                    clear square_final_y
                    clear possible_square_x
                    clear possible_square_y
                    clear num_u_r
                    clear num_u_l
                    clear num_d_l
                    clear num_d_r
                    clear square_final_x
                    clear square_final_y
                end
                
                %% ANALYZED THE SQUARES FOUND
                if bb>=2
                    % Once squares are found for the different couple, bad squares are removed
                    [sqr_x_good,sqr_y_good,pot_couple_good]=remove_bad_squares(possible_couple,pot_couple,bb,sqr_x,sqr_y);
                    clear sqr_x
                    clear sqr_y
                    clear pot_couple
                    sqr_x=sqr_x_good;
                    sqr_y=sqr_y_good;
                    pot_couple=pot_couple_good;
                end
                
                
                if bb>0
                    if length(sqr_x(:,1))>1
                        % if there is still more than one square, those
                        % squares will be analyzed once again. 
                        [x_DEF,y_DEF,probability]=average_square(sqr_x,sqr_y,possible_couple,pot_couple);
                        clear sqr_x
                        clear sqr_y
                        sqr_x=x_DEF;
                        sqr_y=y_DEF;
                    end
                    
                    if length(sqr_x(:,1))>1
                        % Value that give the probability of the potntial
                        % gate found to be the real gate.
                        [probability_order,prob_ind]=sort(probability);
                        
                        % If we have more than one gate, the first gate will be the gate corresponding to the side couple with the most side points.
                        % The gate found is reshaped in a square 
                        [gate_1_x,gate_1_y]=reshape_gate(sqr_x(prob_ind(end),:),sqr_y(prob_ind(end),:),gate_image);
                       
                        %Keep all the information on the gate found in the
                        %structure gate
                        
                        [gate,t]=gate_1_pixel_detection(gate_1_x,gate_1_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                        %--------------------------------------------
                        %CHeck if their is a gate 2
                        check=check_gate_2(gate_1_x,gate_1_y,sqr_x(prob_ind(end-1),:),sqr_y(prob_ind(end-1),:));
                        if check==1
                            % The second gate will be the gate
                            % corresponding to the side couple with the
                            % second most side points
                            % The gate found is reshaped in a square
                            [gate_2_x,gate_2_y]=reshape_gate(sqr_x(prob_ind(end-1),:),sqr_y(prob_ind(end-1),:),gate_image);
                            %--------------------------------------------
                            %Keep all the information on the gate found in the
                            %structure gate
                            
                            [gate,t]=gate_2_pixel_detection(gate_2_x,gate_2_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                            %--------------------------------------------
                        end
                    end
                    
                    % In case only one gate is detected
                    if length(sqr_x(:,1))==1
                        %gate found is reshaped in a square                        
                        [gate_1_x,gate_1_y]=reshape_gate(sqr_x(1,:),sqr_y(1,:),gate_image);
                        
                            %Keep all the information on the gate found in the
                            %structure gate
  
                        [gate,t]=gate_1_pixel_detection(gate_1_x,gate_1_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                    end
                    clear gate_1_x
                    clear gate_1_y
                    clear gate_2_x
                    clear gate_2_y
                    clear probability
                    
                else
                    % If no gate is detected and if we have a gate on the
                    % previous image
                    if t>=2
                        % SIFT feature matching is use to find a gate 
                        [gate_1_x,gate_1_y,gate_check]=sift_features(gate(t-1).gate_1_x,gate(t-1).gate_1_y,imread(['WashingtonOBRace/',img_files(r).name]),gate_image);
                        % If criteria for a gate are respected
                        if gate_check==1
                            
                            [gate,t]=gate_1_SIFT(gate_1_x,gate_1_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                        else
                            % If criteria for a gate are not respected
                            [gate,t]=no_gate_found(gate_image,gate,t,r,img_files(r).name,show_gate);
                        end
                    end
                end
                
                
                clear gate_image
                clear side_point_y
                clear side_point_x_sort
                clear spf_x
                clear spf_y
                clear Border_x
                clear T
                clear sqr_x
                clear sqr_y
                clear num_spf
                clear possible_couple
                
            else
                % IF no possible couple found a gate,sift features are used
                % to found a gate
                if t>=2
                    [gate_x_1,gate_y_1,gate_check]=sift_features(gate(t-1).gate_1_x,gate(t-1).gate_1_y,imread(['WashingtonOBRace/',img_files(r-1).name]),gate_image);
                    % If criteria for a gate are respected
                    if gate_check==1
                        % Keep the information on the gate found in the
                        % structure gate
                        [gate,t]=gate_1_SIFT(gate_1_x,gate_1_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                    else
                        % If criteria for a gate are not respected
                        [gate,t]=no_gate_found(gate_image,gate,t,r,img_files(r).name,show_gate);
                    end
                end
            end
        else
            if t>=2
                % Apply SIFT features if not enough spf are found
                [gate_x_1,gate_y_1,gate_check]=sift_features(gate(t-1).gate_1_x,gate(t-1).gate_1_y,imread(['WashingtonOBRace/',img_files(r-1).name]),gate_image);
                % If criteria for a gate are respected
                if gate_check==1
                    [gate,t]=gate_1_SIFT(gate_1_x,gate_1_y,gate_image,gate,t,r,img_files(r).name,show_gate);
                else
                    % If criteria for a gate are not respected
                    [gate,t]=no_gate_found(gate_image,gate,t,r,img_files(r).name,show_gate);
                end
            else
                [gate,t]=no_gate_found(gate_image,gate,t,r,img_files(r).name,show_gate);
            end
        end
    else
        [gate,t]=no_gate_found(gate_image,gate,t,r,img_files(r).name,show_gate);
    end
    
end
toc
%save('gate.mat','gate')




