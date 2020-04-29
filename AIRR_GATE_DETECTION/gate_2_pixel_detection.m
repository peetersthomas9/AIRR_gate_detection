function [gate,t]=gate_2_pixel_detection(gate_2_x,gate_2_y,gate_image,gate,t,r,name_im,show_gate)
%----------------------------------------------------------
% function that will save the value found for the second gate for this image
% in this structure.the image and the gate can be visualized when show_gate=1

% The structure gate give for each image the x and y coordinates of the
% four corners for gate 1 and 2, the name of the image analyzed and the
% method used to find this gate
%----------------------------------------------------------
       
       if show_gate==1
        figure(t)
        imshow(gate_image)
        hold on
        plot(gate_2_x,gate_2_y,'m-')
        name=(['gate_2',name_im]);
        title(name);
       end
        %saveas(figure(t), [pwd (['/detect_cote_test/',name])])
        gate(t).image=name_im;
        gate(t).gate_2_x=gate_2_x(1:4);
        gate(t).gate_2_y=gate_2_y(1:4);
        gate(t).method='pixel_detection';

end