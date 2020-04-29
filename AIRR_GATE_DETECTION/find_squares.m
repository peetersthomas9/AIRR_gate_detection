function [square_final_x,square_final_y,var]=find_squares(Bord_x_u_l,Bord_y_u_l,Bord_x_u_r,Bord_y_u_r,Bord_x_d_r,Bord_y_d_r,Bord_x_d_l,Bord_y_d_l,dist,gate_image)
%--------------------------------------------------------------------
% Function that will compare all the candidate for the corner together to
% see if we find a gate. A test on the distance between the different
% corners and a test on the intensity of the pixel around the corners is
% made to be sure that we find a gate

% square_final_x : x coordinate of the four corners of the potential gate found 
% square_final_y : y coordinate of the four corners of the potential gate found
% var : if var >0, a gate is found
%--------------------------------------------------------------------
var=0;
for q=1:length(Bord_x_u_l)
    for s=1:length(Bord_x_u_r)
        for d=1:length(Bord_x_d_r)
            for f=1:length(Bord_x_d_l)
                %--------------------------------------------------------------------
                % Condition on distance between the different corners
                if abs(Bord_x_u_r(s)-Bord_x_u_l(q)-dist)<dist/5  %20
                    if abs(Bord_y_d_l(f)-Bord_y_u_l(q)-dist)<dist/4  %25
                        if abs(Bord_x_d_r(d)-Bord_x_d_l(f)-dist)<dist/5  %20
                            if abs(Bord_y_d_r(d)-Bord_y_u_r(s)-dist)<dist/4 %25
                %------------------------------------------------------------------
                   % Condition of pixel intensity around the gate (check if we find enough white and blue pixels)    
                                pix_blanc=nbr_pixel_blanc(gate_image,Bord_x_u_r(s),Bord_y_u_r(s));
                                pix_bleu=nbr_pixel_bleu(gate_image,Bord_x_u_r(s),Bord_y_u_r(s));
                                if pix_blanc>=1 & pix_bleu>=5 & pix_blanc+pix_bleu>40
                                    pix_blanc=nbr_pixel_blanc(gate_image,Bord_x_u_l(q),Bord_y_u_l(q));
                                    pix_bleu=nbr_pixel_bleu(gate_image,Bord_x_u_l(q),Bord_y_u_l(q));
                                    if pix_blanc>=1 & pix_bleu>=5 & pix_blanc+pix_bleu>40
                                        pix_blanc=nbr_pixel_blanc(gate_image,Bord_x_d_l(f),Bord_y_d_l(f));
                                        pix_bleu=nbr_pixel_bleu(gate_image,Bord_x_d_l(f),Bord_y_d_l(f));
                                        if pix_blanc>=1 & pix_bleu>=5 & pix_blanc+pix_bleu>40
                                            pix_blanc=nbr_pixel_blanc(gate_image,Bord_x_d_r(d),Bord_y_d_r(d));
                                            pix_bleu=nbr_pixel_bleu(gate_image,Bord_x_d_r(d),Bord_y_d_r(d));
                                            if pix_blanc>=1 & pix_bleu>=5 & pix_blanc+pix_bleu>40
                 %------------------------------------------------------------------
                 % The information on the gate found with those four
                 % corners found are kept in the matrice possible_square_x
                 % and possible_square_y
                                                var=var+1;
                                                possible_square_x(var,:)=[Bord_x_u_l(q) Bord_x_u_r(s) Bord_x_d_r(d) Bord_x_d_l(f)];
                                                possible_square_y(var,:)=[Bord_y_u_l(q) Bord_y_u_r(s) Bord_y_d_r(d) Bord_y_d_l(f)];
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

if var>=2
    %If more than 1 square is found for the same side couple we make an
    %average of those squares
    square_final_x=mean(possible_square_x);
    square_final_y=mean(possible_square_y);
end
if var==1
    square_final_x=possible_square_x;
    square_final_y=possible_square_y;
end
if var==0
    square_final_x=[];
    square_final_y=[];
end
end