classdef SVM < handle
    
    properties
        %k ���s�Ӽ� ; points:�s�� ; cluster : ��s�i���k��
        k
        points
        cluster
        axis_x
        axis_y
        axis_z
        image_count
        is_2D
    end
     methods
            function obj = SVM(k,axis_x,axis_y,axis_z)   %�غc�禡�A�禡���W�@�P�A���������ܼƪ���l��
                obj.k = k; 
                obj.axis_x = axis_x; 
                obj.axis_y = axis_y; 
                obj.image_count = 0;
                switch nargin
                    case 3
                        obj.is_2D = true;
                    case 4
                        obj.axis_z = axis_z;
                        obj.is_2D = false;
                end
            end
            
            function data = Output_df(obj)
                DataFrame = readtable ('data/Iris.csv')	;	% �N data.csv �����eŪ��x�} A	
                if obj.is_2D
                    data= cell2mat(table2cell(DataFrame(:,{obj.axis_x,obj.axis_y})));
                else
                     data= cell2mat(table2cell(DataFrame(:,{obj.axis_x,obj.axis_y,obj.axis_z})));
                end
            end
            
            function obj=initialPoints(obj,data)
                %�H�����k���I:�q����I�����(�i�୫��)
                r = randi([1 length(data)],1,obj.k);
                %disp(data(r,:));
                obj.points=data(r,:); 
            end
            
            function res=Clustering(obj,data)
                %��Ҧ��I�i���k��
                if obj.is_2D
                    cluster_index=zeros(size(data,1),1);
                    for i= 1:length(data)
                        shortDis=realmax;
                        shortIndex=-1;
                        for j =1: obj.k
                            dis=(data(i,1)-obj.points(j,1))^2+((data(i,2)-obj.points(j,2)))^2;
                            if(dis<shortDis)
                                shortDis=dis;
                                shortIndex=j;
                            end
                        end
                        cluster_index(i,1)=shortIndex;
                    end
                    res=[data cluster_index];
                    res=array2table(res,'VariableNames',{'x','y','group'});
                else
                    cluster_index=zeros(size(data,1),1);
                    for i= 1:length(data)
                        shortDis=realmax;
                        shortIndex=-1;
                        for j =1: obj.k
                            dis=(data(i,1)-obj.points(j,1))^2+((data(i,2)-obj.points(j,2)))^2+((data(i,3)-obj.points(j,3)))^2;
                            if(dis<shortDis)
                                shortDis=dis;
                                shortIndex=j;
                            end
                        end
                        cluster_index(i,1)=shortIndex;
                    end
                    res=[data cluster_index];
                    res=array2table(res,'VariableNames',{'x','y','z','group'});
                end
            end
  
            function Plot_df(obj,data)    
                hold off
                if obj.is_2D
                    for i=1:obj.k
                       tf = (data.group == i);
                       scatter(data.x(tf),data.y(tf),'o')
                       hold on
                    end
                    obj.image_count= obj.image_count+1;
                    scatter(obj.points(:,1),obj.points(:,2),'r','x')
                    xlabel(obj.axis_x)
                    ylabel(obj.axis_y)
                    title(['K-means : iteration ',num2str(obj.image_count)])
                else
                     for i=1:obj.k
                       tf = (data.group == i);
                       scatter3(data.x(tf),data.y(tf),data.z(tf),'o')
                       hold on
                    end
                    obj.image_count= obj.image_count+1;
                    scatter3(obj.points(:,1),obj.points(:,2),obj.points(:,3),'r','x')
                    view(-120, 20)
                    xlabel(obj.axis_x)
                    ylabel(obj.axis_y)
                    zlabel(obj.axis_z)
                    title(['K-means : iteration ',num2str(obj.image_count)])
                end
            end
            
             function recalculate_points(obj,data)         
                for i=1:obj.k
                    fprintf('for cluster %d',i)
                   tf = (data.group == i);
                   disp([mean(data.x(tf)),mean(data.y(tf))])
                   obj.points(i,1)=mean(data.x(tf));
                   obj.points(i,2)=mean(data.y(tf));
                   if ~obj.is_2D
                        obj.points(i,3)=mean(data.z(tf));
                   end
                end
            end
    end
    methods (Static)
         function Plot_3d_df(data)
           plot3(data(:,1),data(:,2),data(:,3),'o')
         end
       
    end
end

