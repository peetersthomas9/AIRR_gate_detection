# AIRR_gate_detection
matlab algortihm to detect the gate

To run this algortihm : 

The image where we want to detect the gate must be add in a folder named : 'WashingtonOBRace'
the matlab file 'AIRR_gate_detection.mat' must be open and be run. 
At the begining of the algorithm, a loop for is add and allows to choose how many images we want to analyse
The algorthm used different function to carry out different tasks. A short description on the function and on the variables used are put at the begining of each function used 
Once the algorithm is run, all the information about the gate detected can be found in the structure gate (position of the corner, name of the image, method found to detect the gate)
The variable 'show_gate' can be put equal to 1 to visualize on a figure the gate detection. 

!!!  Important : For the SIFT features the 'thevlfeat-0.9.21/toolbox' must be add to the matlab path. 
This toolbox can be found and download here: http://www.vlfeat.org/download/vlfeat-0.9.21-bin.tar.gz 
The toolbox must be extract and the 'thevlfeat-0.9.21/toolbox' must be add to the matlab path.
THis toolbox is found on the VLfeat open source library.


Once the gates are found on the 308 images, they are analyzed using the matlab file : 'ROC_curve.mat'
values for the gate structure found using 'AIRR_gate_detection.mat' have been saved in this folder and is loaded in 'ROC_curve.mat'. 
The files 'corners.cvs' must also be add in a folder named : 'WashingtonOBRace' to be able to run 'ROC_curve.mat'.
