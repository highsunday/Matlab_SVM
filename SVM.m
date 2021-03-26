classdef SVM < handle
    
    properties
        target
        dataframe
    end
     methods
            function obj = SVM(target)   %建構函式，函式類名一致，完成類中變數的初始化
               obj.target=target;
            end
            
            function Read_df(obj,path)
                DataFrame = readtable (path)	;	% 將 data.csv 的內容讀到矩陣 A	
                X=DataFrame(:,1:end-1);
                y=array2table((DataFrame.Species==obj.target));% 將不是target的歸為0;是的為1
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

