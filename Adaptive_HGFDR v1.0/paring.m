% function[data]=parting(data,i,j,k)
% function[ Att K ]=parting(data,m,n,k,step_i,step_j,step_z)
 function[ Att K ]=p_paring(data,m,n,k,step_i,step_j,step_z,At_att)
%     step_i =2; 
%     step_j =2;
%     step_z =1;
     ID=1;
     s_i = 1 ;
     e_i = step_i;
     for a =1: int32(m/step_i)
         s_j = 1;
         e_j = step_j;
         for b =1:int32(n/step_j) 
             s_z = 1;
             e_z = step_z;
             for c=1:int32(k/step_z)
              % 属性表          
%               Att{ID,1} = ['lat',num2str(a),'lon',num2str(b),'lev',num2str(c),';',...
%                   num2str(s_i),':', num2str(e_i),';',...
%                   num2str(s_j),':', num2str(e_j),';',...
%                   num2str(s_z),':', num2str(e_z)]
              % 属性表
              Att(ID).ID=ID;
              Att(ID).lon.min = s_i; Att(ID).lon.max = e_i;
              Att(ID).lat.min = s_j; Att(ID).lat.max = e_j;
              Att(ID).lev.min = s_z; Att(ID).lev.max = e_z;
              Att(ID).IDD = [a b c];
              Att(ID).time = At_att.time;
              % 分块
              ID=ID+1;
              K{a,b,c} = data(s_i:e_i,s_j:e_j,s_z:e_z);
              
             s_z = s_z + step_z ;
             e_z = e_z + step_z ; 
             if e_z+1> k
                e_z = k;
             end
             end
             s_j = s_j + step_j ;
             e_j = e_j + step_j ; 
             if e_j +1 > n
                 e_j = n;
             end
        end
        s_i = s_i + step_i ;
        e_i = e_i + step_i ; 
        if e_i +1 >m
            e_i = m;
        end
     end
 end    
 