%ZFP algorithm
%The first step of zfp algorithm:.nc into .bin file
%Input: data_T, convert the data into 26 1024*512 bin format files, the format type is double.
for i=1:26
    fid=fopen(["G:\180723\180723\Var_bin\"+i+"T.bin"],"wb");
    fwrite(fid,reshape(data_T(:,:,i),[8,1024*512/8]),'double');
    fclose(fid);
end
%The second step is to start the code in the ¡®inplace¡¯ file (C++)
%
%
%
%The third step is to import the compressed txt file output from the'Inplace' file into matlab.

for i=1:26
A=importdata(['G:\180723\180723\Var_txt\',num2str(i),'_T.txt']);
AA=A';
data_zfp(:,:,i)=single(reshape(AA,1024,512));
% error_zfp_t(i) = error_rank1(data(:,:,i),data_zfp(:,:,i));
end
%At this time, data_zfp represents the data compressed by zfp.
