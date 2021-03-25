classdef SVM < handle
    
    properties
        X
        y
    end
     methods
            function obj = SVM()   %建構函式，函式類名一致，完成類中變數的初始化
               obj.X=0;
            end
            
            function Read_df(obj,path)
                DataFrame = readtable (path)	;	% 將 data.csv 的內容讀到矩陣 A	
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

