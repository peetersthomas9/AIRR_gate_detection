function [gate,t]=no_gate_found(gate_image,gate,t,r,name_im,show_gate)
        t=t+1;
%--------------------------------------
% function used when no gate is found 
%--------------------------------------

if show_gate==1
        figure(t)
        imshow(gate_image)
        name=(['gate_1',name_im]);
        title(name);
end
%         saveas(figure(t), [pwd (['/detect_cote_test/',name])])
        gate(t).image=name_im;
        gate(t).gate_1_x=[0 0 0 0];
        gate(t).gate_1_y=[0 0 0 0];
        gate(t).gate_2_x=[];
        gate(t).gate_2_y=[];
        gate(t).method='NO GATE FOUND';

end
