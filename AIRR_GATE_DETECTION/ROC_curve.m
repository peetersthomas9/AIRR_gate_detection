
%% ANALYZE THE VALUES OF GATE FOUND WITH 'AIRR_gate_detecion.m'
% READ the value given in the corners.cvs file 
formatSpec = '%s %d %d %d %d %d %d %d %d';
fid = fopen('WashingtonOBRace/corners.csv','r'); % open the file

data = textscan(fid, formatSpec,...
                     'headerlines', 0,...
                     'delimiter',',',...
                     'TreatAsEmpty','NA'); % read the  file

fclose(fid); % close the file

% Load the value found with the file 'AIRR_gate_detection'
load gate

n=1;
i=1;
check=0;

 %---------------------------------
 % Loop while to take for each image the data on the first gate
while n<=687  

    if strcmp(data{1,1}(n),data{1,1}(n+1))==1 & strcmp(data{1,1}(n),data{1,1}(n+2))==1 & strcmp(data{1,1}(n),data{1,1}(n+3))==1
                 dist_1=data{1,4}(n)-data{1,2}(n);
         dist_2=data{1,4}(n+1)-data{1,2}(n+1);
         dist_3=data{1,4}(n+2)-data{1,2}(n+2);
         dist_4=data{1,4}(n+3)-data{1,2}(n+3);
         dist=[dist_1,dist_2,dist_3,dist_4];
         [M,ind]=max(dist);
         
         gate_1_real(i).x=[data{1,2}(n+ind-1) data{1,4}(n+ind-1) data{1,6}(n+ind-1) data{1,8}(n+ind-1)];
         gate_1_real(i).y=[data{1,3}(n+ind-1) data{1,5}(n+ind-1) data{1,7}(n+ind-1) data{1,9}(n+ind-1)];
         gate_1_real(i).name=data{1,1}(n+ind-1);
         n=n+4;
         i=i+1;
         check=1;
    end
     if strcmp(data{1,1}(n),data{1,1}(n+1))==1 & strcmp(data{1,1}(n),data{1,1}(n+2))==1 & check==0
         %3 gate-> found gate 1;
         dist_1=data{1,4}(n)-data{1,2}(n);
         dist_2=data{1,4}(n+1)-data{1,2}(n+1);
         dist_3=data{1,4}(n+2)-data{1,2}(n+2);
         dist=[dist_1,dist_2,dist_3];
         [M,ind]=max(dist);
         
         gate_1_real(i).x=[data{1,2}(n+ind-1) data{1,4}(n+ind-1) data{1,6}(n+ind-1) data{1,8}(n+ind-1)];
         gate_1_real(i).y=[data{1,3}(n+ind-1) data{1,5}(n+ind-1) data{1,7}(n+ind-1) data{1,9}(n+ind-1)];
         gate_1_real(i).name=data{1,1}(n+ind-1);
         n=n+3;
         i=i+1;
         check=1;
     end
     if strcmp(data{1,1}(n),data{1,1}(n+1))==1 & check==0
         % 2 gate-> found gate 1 
         dist_1=data{1,4}(n)-data{1,2}(n);
         dist_2=data{1,4}(n+1)-data{1,2}(n+1);
         dist=[dist_1,dist_2];
         [M,ind]=max(dist);
         gate_1_real(i).x=[data{1,2}(n+ind-1) data{1,4}(n+ind-1) data{1,6}(n+ind-1) data{1,8}(n+ind-1)];
         gate_1_real(i).y=[data{1,3}(n+ind-1) data{1,5}(n+ind-1) data{1,7}(n+ind-1) data{1,9}(n+ind-1)];
         gate_1_real(i).name=data{1,1}(n+ind-1);
         check=1;
         i=i+1;
         n=n+2;
     end
     if strcmp(data{1,1}(n),data{1,1}(n+1))==0 & check==0
         % 1 gate-> 
         gate_1_real(i).x=[data{1,2}(n) data{1,4}(n) data{1,6}(n) data{1,8}(n)];
         gate_1_real(i).y=[data{1,3}(n) data{1,5}(n) data{1,7}(n) data{1,9}(n)];
         gate_1_real(i).name=data{1,1}(n);
         n=n+1;
         i=i+1
     end
     check=0;
end
n=689;
         gate_1_real(308).x=[data{1,2}(n) data{1,4}(n) data{1,6}(n) data{1,8}(n)];
         gate_1_real(308).y=[data{1,3}(n) data{1,5}(n) data{1,7}(n) data{1,9}(n)];
         gate_1_real(308).name=data{1,1}(n);
  
 %---------------------------------
 for i=1:308
      %--------------------------------------------------
 %true gate
 x_true=double(gate_1_real(i).x);
 y_true=double(gate_1_real(i).y);
 poly_true=polyshape(x_true,y_true);
 area_true=polyarea(x_true,y_true);   % real area of the gate
 data_name(i)=gate_1_real(i).name;
 %-----------------------------------------------------
 %gate found
   x_test=int32(gate(i).gate_1_x);
   y_test=int32(gate(i).gate_1_y);
   poly_test=polyshape(x_test,y_test); % found area of the gate
   area_test=polyarea(x_test,y_test);
 %----------------------------------------------------
 % find intersection 
 polyout=intersect(poly_test,poly_true); % Find the intersection between the real gate and the gate found
 intersect_area=polyarea(polyout.Vertices(:,1),polyout.Vertices(:,2)); % calculare the area of the intersection
 IoU(i)=intersect_area/(area_test+area_true-intersect_area); %Formula for the IoU (intersection over union)
 FPR(i)=(area_test-intersect_area)/area_test 

 end
 
 average_value=mean(IoU)
 negative=IoU([93 97 98 101 109 111 165 166 181 307]);
 positive=IoU(:);
 positive([93 97 98 101 109 111 165 166 181 307])=[];
 

% find FPR and TPR for different treshold for the IoU
for treshold=0:0.02:1
     n=n+1;
     ratio_true_positive(n)=length(find(positive(:)>=1-treshold))/length(positive);
     false_positive_ratio(n)=length(find(negative(:)>=1-treshold))/length(negative);
     
end

% PLOT ROC CURVE
 plot(false_positive_ratio,ratio_true_positive)

%PLOT FALSE POSITIVE RATIO ON THE 308 IMAGES
FPR_sort=sort(FPR)
x=[1:308]
plot(x,FPR_sort)
 
 