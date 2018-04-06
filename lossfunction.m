%% calculation the loss in optimase the RT between sick and cam
%se(1:3) = roll yaw pitch
%se(4:6) = tx ty tz
function loss_back = lossfunction (se,datain)
       R= RPYtoR(se(1:3));
       t= [se(4);se(5);se(6)];
       RTl2c = [R , t;
            0 0 0 ,1];
        num_cal = size(datain,1);
        loss =[];
        scale = 0.001; %mm to m
        for i =1 :1 :num_cal
            num_points = size(datain{i,1},1);
            tmp_loss = zeros(num_points,1);
            tb2c = datain{i,3}(1:3,4) * scale;
            Rb2c =  datain{i,3}(1:3,1:3);
            nbinc = Rb2c(1:3,3);
            for j = 1:1:num_points
                ori = [datain{i,2}(datain{i,1}(j),:)';1];
                aft = RTl2c * ori;
                tmp_loss(j) = nbinc' * (aft(1:3) -  tb2c)/(norm(nbinc,2)*norm(aft(1:3) -  tb2c,2));
            end
            loss = [loss ; tmp_loss];
        end
        
        
        loss_back = norm(loss,2)/num_cal;




end