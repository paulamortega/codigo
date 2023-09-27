function [H, fnew]=calcF_A_Star(xnext, goal, gnew)

H=calcH_A_Star(xnext, goal);

fnew=gnew+H;

end