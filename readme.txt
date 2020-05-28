Adaptive_HGFDR v1.0
===

INTRODUCTION
------------
Adaptive_HGFDR v1.0 is an open code for lossy compression of climate model data.Adaptive_HGFDR V1.0 was developed by the School of Geographical Science of Nanjing Normal University (Key Laboratory of Virtual Geographic Environment of the Ministry of Education). 

Because few methods consider that the uneven distribution of compression errors will affect the compression quality of climate model data.Here we develop an adaptive lossy compression method with the stable compression error for earth system model data based on Hierarchical Geospatial Field Data Representation (HGFDR).Using optimal compression parameter selection rule and an adaptive compression algorithm, our method, the Adaptive-HGFDR V1.0,  achieved the data compression under the constraints that the compression error is as stable as possible through each dimension. 

COMPONENT
------------
Adaptive_HGFDR V1.0 contains four different parts: 
1. The header files of the lossy compression algorithm Adaptive_HGFDR V1.0.£¨Adaptive_HGFDR.m, adaptive_rank2.m, error_rank2.m, and paring.m£©
2. A series of open source Matlab tensor libraries. £¨htucker_1.2 and tensor_toolbox_2.6£©
3. Experimental data T in .mat format for testing£¨"T.mat" in the "Data" folder£©
4. A test case for Adaptive_HGFDR v1.0 compression algorithm£¨test.m£©


DATA
------------
"Data" file contains data for experiments used in the paper, including T temperature data. The data set includes Air Temperature data (T) stored as a 1024*512*26(latitude longitude height) tensor.The experimental data are Large-scale Data Analysis and Visualization Symposium Data obtained from (OSDC) Open Science Data Cloud. This data set consists of files from a series of global climate dynamics simulations run on the Titan supercomputer at Oak Ridge National Laboratory in 2013 by postdoctoral researcher Abigail Gaddis, Ph.D. The simulations were performed at approximately 1/3-degree spatial resolution, or a mesh size of 1024x512 for 2D. We downloaded this simulation data in the common NetCDF (network Common Data Form) format in 2016 from https://www.opensciencedatacloud.org/.

ENVIRONMENT
------------
Research experiments were performed by the MATLAB R2017a environment on a Windows 10 Workstation (HP Compaq Elite 8380 MT) with Intel Corei7-3770 (3.4 GHz) processors and 8 GB of RAM.
htucker_1.2 and tensor_toolbox_2.6 are open source Matlab tensor libraries. Before running the code, add these two libraries and the header files of the lossy compression algorithm Adaptive_HGFDR V1.0 to the environment. 

TEST
------------
Open test.m and run according to the data and instructions
Explanation:
%The Adaptive_HGFDR function is the main part of the adaptive-HGFDR algorithm in this paper.
%This code can achieve the compression of climate model data.
%The input "data" of this function is the input climate model data.
%The function input "error" is the compression error of the climate model data you set.
%The input data of the function "p_i1", "p_j1", and "p_k1" are the sizes of each data block in the x, y, and z dimensions when the data is divided.
%The input data of the first experiment in the paper is temperature data T, the error is 1e-4, and the size of the block is 256 * 128 * 26
%The output data of the function "BOT", "err", "com_ratio", "time", "error_std", and "error_x" are the compressed data, compression error, compression ratio, compression time, standard deviation of the X-dimensional slice error, and the X-dimensional slice error
