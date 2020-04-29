function [gate,t]=gate_1_pixel_detection(gate_1_x,gate_1_y,gate_image,gate,t,r,name_im,show_gate)       
%----------------------------------------------------------
% function that will save the value found for the first gate for this image
% in this structure.the image and the gate can be visualized when show_gate=1

% The structure gate give for each image the x and y coordinates of the
% four corners for gate 1 and 2, the name of the image analyzed and the
% method used to find this gate
%----------------------------------------------------------
        t=t+1;
        if show_gate==1
        figure(t)
        imshow(gate_image)
        hold on
        plot(gate_1_x,gate_1_y,'m-')
        name=(['gate_1',name_im]);
    %    title(name);
        end
%         saveas(figure(t), [pwd (['/detect_cote_test/',name])])
        gate(t).image=name_im;
        gate(t).gate_1_x=gate_1_x(1:4);
        gate(t).gate_1_y=gate_1_y(1:4);
        gate(t).gate_2_x=[];
        gate(t).gate_2_y=[];
        gate(t).method='pixel_detection';

end