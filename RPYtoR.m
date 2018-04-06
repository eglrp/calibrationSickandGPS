
%from RPY angle to Rotation Matrix
%Ori(1) = rx Ori(2)=ry   Ori(3)=rz
%旋转顺序为zyx,绕自身
function R=RPYtoR(Ori)

Rx=[1,0,0;
    0,cos(Ori(1)),-sin(Ori(1));
    0,sin(Ori(1)),cos(Ori(1));];

Ry=[cos(Ori(2)),0,sin(Ori(2));
    0,1,0;
    -sin(Ori(2)),0,cos(Ori(2));];

Rz=[cos(Ori(3)),-sin(Ori(3)),0;
    sin(Ori(3)),cos(Ori(3)),0;
    0,0,1;];

% R=Rx*Ry*Rz;
R = Rz*Ry*Rx;


end