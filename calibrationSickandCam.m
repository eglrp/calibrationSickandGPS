%% datain
fileFolder = fullfile('/home/xiesc/cal_sick_cam');
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
se_cal = fminsearch(min_fun,[0,-pi/2,0,0,0,2],optimset('MaxFunEvals',40000,'MaxIter',40000,...
                            'Algorithm','levenberg-marquardt','ToLX',1e-6,'Display','iter'));


