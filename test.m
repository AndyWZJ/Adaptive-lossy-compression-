[BOT err com_ratio time error_std error_x] = Adaptive_HGFDR(data,error,p_i1,p_j1,p_k1);
%The Adaptive_HGFDR function is the main part of the adaptive-HGFDR algorithm in this paper.
%This code can achieve the compression of climate model data.
%The input "data" of this function is the input climate model data.
%The function input "error" is the compression error of the climate model data you set.
%The input data of the function "p_i1", "p_j1", and "p_k1" are the sizes of each data block in the x, y, and z dimensions when the data is divided.
%The input data of the first experiment in the paper is temperature data T, the error is 1e-4, and the size of the block is 256 * 128 * 26
%The output data of the function "BOT", "err", "com_ratio", "time", "error_std", and "error_x" are the compressed data, compression error, compression ratio, compression time, standard deviation of the X-dimensional slice error, and the X-dimensional slice error