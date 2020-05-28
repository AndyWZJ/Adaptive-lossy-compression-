   function[BOT err com_ratio time error_std error_x] = Adaptive_HGFDR(data,error,p_i1,p_j1,p_k1)
%The Adaptive_HGFDR function is the main part of the adaptive-HGFDR algorithm in this paper.
%This code can achieve the compression of climate model data.
%The input "data" of this function is the input climate model data.
%The function input "error" is the compression error of the climate model data you set.
%The input data of the function "p_i1", "p_j1", and "p_k1" are the sizes of each data block in the x, y, and z dimensions when the data is divided.
%The input data of the first experiment in the paper is temperature data T, the error is 1e-4, and the size of the block is 256 * 128 * 26
%The output data of the function "BOT", "err", "com_ratio", "time", "error_std", and "error_x" are the compressed data, compression error, compression ratio, compression time, standard deviation of the X-dimensional slice error, and the X-dimensional slice error
    odata(:,:,:) = data;
   [p_i,p_j,p_k] = size(data);
   t_time = p_k;
   if (rem(p_i,2)==0&&rem(p_j,2)==0&&rem(p_k,2)==0)
   else
       if rem(p_i,2)~=0
           p_i = p_i+1;
           data(p_i)=zeros(p_j,p_k);
       elseif rem(p_j,2)~=0
           p_j = p_j+1;
           data(p_j)=zeros(p_i,p_k);
       elseif rem(p_k,2)~=0
           p_k = p_k+1;
           data(:,:,p_k)=zeros(p_i,p_j);
       end
   end
   At_att.lon.min = 0;At_att.lon.max = p_i;
   At_att.lat.min = 0;At_att.lat.max = p_j;
   At_att.lev.min = 0;At_att.lev.max = p_k;
   At_att.time=1;
    [Att data1] = paring(data,p_i,p_j,p_k,p_i1,p_j1,p_k1,At_att);
    [data1_x data1_y data1_z]=size(data1);
    data1_num = data1_x*data1_y*data1_z;
    rank_all = 0;
    error_all = 0;
    cap_all = 0;
    [a b c] = size(data1);
    sum = a*b*c;
    Add = 1;
    ada = [];
    data_d = [];
    data1_size= size(data1{1,1,1});
    Rank_sort = sort(data1_size);
    max_Rank = Rank_sort(3);
    t111=clock;
    for i = 1:a
        for j=1:b
            for k=1:c                
                data_d = data1{i,j,k}; 
                t1{Add} = clock;
                [exist_rank error_e(Add) cap_e(Add) adap_r]= adaptive_rank2(data_d,max_Rank,error);
                t2{Add} = clock;
                t3{Add}=etime(t2{Add},t1{Add});
                adap_rr(Add)=adap_r;
                error_all = error_all + error_e(Add);
                cap_all = cap_all + cap_e(Add);
                rank_all = rank_all + adap_r;
                opts.max_rank = adap_r;
                BOT{i,j,k}.rank = opts.max_rank;
                BOT{i,j,k}.typhoon =  htensor.truncate_ltr(data_d,opts);
                BOT{i,j,k}.tp = full(BOT{i,j,k}.typhoon);
                A{i,j,k} = BOT{i,j,k}.tp;
                error_ee{i,j,k}=error_rank2(data_d,BOT{i,j,k}.tp);
                Add = Add + 1;               
            end
        end
    end
    t222 = clock;
    time=etime(t222,t111);   
    adap_rrr=adap_rr';     
    error=error_e';       
    cap=cap_e';            
    t33=t3';                
    t33_data=cell2mat(t33);
    error_ave = error_all/data1_num;  
    cap_ave = cap_all/data1_num;     
    com_ratio = 1/cap_ave;
    rank_ave = rank_all/data1_num;    
    et111=etime(t222,t111);
    if et111/sum<1.2
        disp('Compression complete ');
    else
        disp('Please re-enter compression time');
    end
    data_adap_tp=cell2mat(A);
    data_adap_finish = data_adap_tp(:,:,1:t_time);
    %======================================================================
    
    for ii = 1:p_i
       error_x(ii) = error_rank2(odata(ii,:,:),data_adap_finish(ii,:,:));
    end
    error_jing=error_x';
    error_std =std(error_jing);
    err = error_rank2(odata,data_adap_finish);
    

end