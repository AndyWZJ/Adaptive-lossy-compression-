% AΪԭʼ���ݣ�BΪ�ع�������
function[error_ratio]=error_rank2(data,redata)
   error = abs(data-redata);
   ten_error = tensor(error);
   ten_alldata = tensor(data);
   error_ratio = norm(ten_error)/norm(ten_alldata);
%     error_ratio = norm(ten_error)^2;
end