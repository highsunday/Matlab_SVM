classdef SVM < handle
    
    properties
        target
        dataframe
    end
     methods
            function obj = SVM(target)   %�غc�禡�A�禡���W�@�P�A���������ܼƪ���l��
               obj.target=target;
            end
            
            function Read_df(obj,path)
                DataFrame = readtable (path)	;	% �N data.csv �����eŪ��x�} A	
                X=DataFrame(:,1:end-1);
                y=array2table((DataFrame.Species==obj.target));% �N���Otarget���k��0;�O����1
                obj.dataframe=[X y];
            end
            
            function Plot_2d(obj)
                DataFrame=obj.dataframe;
                class_1=DataFrame(DataFrame.Var1,:);
                class_2=DataFrame(~DataFrame.Var1,:);
                scatter(class_1.SepalLengthCm,class_1.SepalWidthCm,'b','.')
                hold on;
                scatter(class_2.SepalLengthCm,class_2.SepalWidthCm,'r','.')
                xlabel('SepalLengthCm')
                ylabel('SepalWidthCm')
            end
     end
end

