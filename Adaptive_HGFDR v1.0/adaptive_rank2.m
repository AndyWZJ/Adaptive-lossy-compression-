%==========================================================================
% ����ӦRankֵ,����ΪdataΪԭʼ���ݣ�max_RankΪRank�����ȡֵ
% exist_rankΪ�Ƿ�������rank,����Ϊ1��������Ϊ0
% error_eΪ���rank����adap_rankΪ���rankֵ��ȷ�е�ֵ
% ��������data�����������ݣ������е�һ�����ݣ���������������Ӧ�㷨������main,m
%==========================================================================
function[ exist_rank error_e cap_e adap_rank ]=adaptive_rank2(data,max_Rank,Stand_error)
    error_ratio(1) = 1;
    num = 2;
    s =whos('data');
    cap_a=s.bytes;
    % �趨��Χ,��ԭʼ�����йأ�ȡ���׼��
    %  Stand_dev = Error(data);
    % ѹ���ȳ�ʼ��Com_ratio
    Com_ratio = 0.00000;
    Add = 1;
    error_e = 0;
    exist_rank=[];
    cap_e=[];
    adap_rank=[];
%     Stand_error = 0.078;
% %     Stand_error = 0.01;
    %����㷨��ͨ���趨����ѹ���ȣ�Ѱ������ʵ��ȣ����Ҳ���ܴ����Ȳ����ڡ�
    %Stand_error = 0.001;   %0.006/data1_num  %5.20e-09Ϊԭ������
    Stand_cap =0;          %0.8Ϊԭ���Ĳ���
    % ���ַ�����Ӧrank����
    min_Rank = 1;
    count_dichotomy = -1+ceil((log(max_Rank-min_Rank))/log(2));%?ceil����ȡ�� %���ִ���
    
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
        middle_Rank = floor((min_Rank+max_Rank)/2);% ȡ���ݷ�Χ�м�ֵ
        
        % ��Сֵ���м�ֵ�����ֵ�����ֽ��ʼ��
        %���opts�ǲ�������ֽ�ʱҪ�õĲ�����һ�·ֱ����Сֵ�����ֵ���м�ֵ��һ��
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
                             %���
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
                             %���
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