%==========================================================================
% 自适应Rank值,传参为data为原始数据，max_Rank为Rank的最大取值
% exist_rank为是否存在最佳rank,存在为1，不存在为0
% error_e为最佳rank的误差，adap_rank为最佳rank值有确切的值
% 这个传入的data不是整块数据，是其中的一块数据，它的完整的自适应算法代码是main,m
%==========================================================================
function[ exist_rank error_e cap_e adap_rank ]=adaptive_rank2(data,max_Rank,Stand_error)
    error_ratio(1) = 1;
    num = 2;
    s =whos('data');
    cap_a=s.bytes;
    % 设定误差范围,与原始数据有关，取其标准差
    %  Stand_dev = Error(data);
    % 压缩比初始化Com_ratio
    Com_ratio = 0.00000;
    Add = 1;
    error_e = 0;
    exist_rank=[];
    cap_e=[];
    adap_rank=[];
%     Stand_error = 0.078;
% %     Stand_error = 0.01;
    %这个算法是通过设定误差和压缩比，寻找最合适的秩，因此也可能存在秩不存在。
    %Stand_error = 0.001;   %0.006/data1_num  %5.20e-09为原来参数
    Stand_cap =0;          %0.8为原来的参数
    % 二分法自适应rank计算
    min_Rank = 1;
    count_dichotomy = -1+ceil((log(max_Rank-min_Rank))/log(2));%?ceil是上取整 %二分次数
    
    max_Rank_stand = max_Rank;
    min_Rank_stand = min_Rank;
    
    opts.max_rank = max_Rank;
    max_typhoon =  htensor.truncate_rtl(data,opts);
    max_tp = full(max_typhoon);
    max_s =whos('max_typhoon');
    max_cap=max_s.bytes/cap_a;
    max_error = error_rank2(data,max_tp);
    
    if count_dichotomy == -1
        count_dichotomy = 1;
    end
    for i = 1:count_dichotomy + 1
        middle_Rank = floor((min_Rank+max_Rank)/2);% 取数据范围中间值
        
        % 最小值、中间值、最大值张量分解初始化
        %这个opts是层次张量分解时要用的参数，一下分别对最小值、最大值和中间值算一遍
        opts.max_rank = min_Rank;
        min_typhoon = htensor.truncate_rtl(data,opts);
        min_tp = full(min_typhoon);
        min_s =whos('min_typhoon');
        min_cap(i)=min_s.bytes/cap_a;     
        min_error(i) = error_rank2(data,min_tp);
        
        opts.max_rank = middle_Rank;
        middle_typhoon =  htensor.truncate_rtl(data,opts);
        middle_tp = full(middle_typhoon);
        middle_s =whos('middle_typhoon');
        middle_cap(i)=middle_s.bytes/cap_a;
        middle_error(i) = error_rank2(data,middle_tp);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
        opts.max_rank = max_Rank;
        max_typhoon = htensor.truncate_rtl(data,opts);
        max_tp = full(max_typhoon);
        max_s =whos('max_typhoon');
        max_cap(i)=max_s.bytes/cap_a;
        max_error(i) = error_rank2(data,max_tp);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        max_max_error(1)=max_error(1);
        max_max_cap(1) = max_cap(1);
        min_min_error(1)=min_error(1);
        min_min_cap(1)=min_cap(1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
      if middle_error(i)<Stand_error 
                if middle_cap(i)<Stand_cap
                    adap_rank = middle_Rank;
                    max_Rank = middle_Rank;
                    error_e = middle_error(i);
                    cap_e = middle_cap(i);
                    exist_rank = 1;
                else
                    max_Rank = middle_Rank;
                    if i == count_dichotomy + 1
                        adap_rank = middle_Rank;
                        error_e = middle_error(i);
                        cap_e = middle_cap(i);
                        exist_rank = 1;
                    end
                end
        else if middle_error(i)>Stand_error 
                if middle_cap(i)<Stand_cap
                    min_Rank = middle_Rank;
                    if i == count_dichotomy + 1
%                         adap_rank = middle_Rank;
                        adap_rank = max_Rank;
                        error_e = max_error(i);
                        cap_e = max_cap(i);
%                         error_e = middle_error(i);
                        exist_rank = 1;
                    end
                else
                     k_count_dichotomy = ceil((log(max_Rank_stand-min_Rank_stand))/log(2));
                     max_i=1;
                     min_i=1;
                     for ii = 1:k_count_dichotomy
                         middle_middle_Rank(ii) = floor((max_Rank_stand+min_Rank_stand)/2);
                         opts.max_rank=middle_middle_Rank(ii);
                         maxm_typhoon = htensor.truncate_rtl(data,opts);
                         maxm_tp = full(maxm_typhoon);
                         middle_middle_error(ii) = error_rank2(data,maxm_tp);
                         maxm_s =whos('maxm_typhoon');
                         middle_middle_cap(ii)=maxm_s.bytes/cap_a;
                         if middle_middle_error(ii)<Stand_error
                             max_i=max_i+1;
                             max_Rank_stand=middle_middle_Rank(ii);
                             max_max_error(max_i)=middle_middle_error(ii);
                             max_max_cap(max_i)=middle_middle_cap(ii);
                             %求差
                             max_cha(max_i)=max_max_error(max_i)-Stand_error;
                             if max_cha(max_i)<0
                                 
                                 adap_rank = max_Rank_stand;
                                 error_e = max_max_error(max_i);
                                 cap_e = max_max_cap(max_i);
                                 exist_rank = 0;
%                                  break;
                             end
                         else
                             min_i = min_i+1;
                             min_Rank_stand=middle_middle_Rank(ii);
                             min_min_error(min_i)=middle_middle_error(ii);
                             min_min_cap(min_i)=middle_middle_cap(ii);
                             %求差
                             min_cha(min_i)=min_min_error(min_i)-Stand_error;
                             if min_cha(min_i)<0
                                 adap_rank = min_Rank_stand;
                                 error_e = min_min_error(min_i);
                                 cap_e = min_min_cap(min_i);
                                 exist_rank = 0;
%                                  break;
                             end
                         end
                     end                    
                end             
            end
      end
    end  
    
end