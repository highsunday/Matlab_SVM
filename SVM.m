classdef SVM < handle
    
    properties
        X
        y
    end
     methods
            function obj = SVM()   %�غc�禡�A�禡���W�@�P�A���������ܼƪ���l��
               obj.X=0;
            end
            
            function Read_df(obj,path)
                DataFrame = readtable (path)	;	% �N data.csv �����eŪ��x�} A	
                obj.X=DataFrame(:,1:end-1);
                obj.y=DataFrame.Species;
            end
            
            function Plot_2d(obj)
                scatter(obj.X.SepalLengthCm,obj.X.SepalWidthCm,'b','.')
                xlabel('SepalLengthCm')
                ylabel('SepalWidthCm')
            end
     end
end

