%% datain
fileFolder = fullfile('/media/xiesc/Xie Shichao/北汽标定/left1_6');
calfile=dir(fullfile(fileFolder,'*'));
calfile(1:2)=[];
num_cal = size(calfile,1);
datain = cell(num_cal,1);
for i =1:1:num_cal
    tmp = load([calfile(i).folder  '/' calfile(i).name '/' 'plane.mat']);
    datain{i,1} =  tmp.plane';
    
    tmp = load([calfile(i).folder  '/' calfile(i).name '/' 'xyz.mat']);
    xyz = [tmp.x tmp.y tmp.z];
    datain{i,2} = xyz;
    
    tmp = load([calfile(i).folder  '/' calfile(i).name '/' 'RfF.mat']);
    datain{i,3} =  tmp.RfF;
end

%% calibration 
min_fun=@(se)lossfunction(se,datain);
se_cal = fminsearch(min_fun,[  -1.6172 , 1.1033 ,-3.141,0.0279,-0.4293,-0.7332],optimset('MaxFunEvals',40000,'MaxIter',40000,...
                            'Algorithm','levenberg-marquardt','ToLX',1e-6,'Display','iter'));
%%
 R= RPYtoR(se_cal(1:3));
 t= [se_cal(4);se_cal(5);se_cal(6)];
 RTl2c = [R , t;];
%%
dlmwrite([fileFolder '/../' '6.txt'], RTl2c); 

%% world is lidar
figure
hold on

for i =1:1:1
 mat = load ( [fileFolder '/../'  num2str(i) '.txt']);
  R = mat(1:3,1:3);
  t = mat(1:3,4);
R_c2w = R';
Loc_cam = -R'*t;

DrawCamera(Loc_cam,R_c2w);
end


