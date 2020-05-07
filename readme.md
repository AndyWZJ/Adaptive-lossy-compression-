Adaptive_HGFDR
===

INTRODUCTION
------------

Adaptive_HGFDR is an open source Matlab library for compressed climate model data.The Adaptive_HGFDR function is the main part of the adaptive-HGFDR algorithm in this paper.This code can achieve the compression of climate model data.

Adaptive_HGFDR was developed by the School of Geographical Science of Nanjing Normal University (Key Laboratory of Virtual Geographic Environment of the Ministry of Education),

Adaptive_HGFDR was originally designed only for 3D climate model data and can achieve high compression. Since climate data are typically defined over space-time dimensions and presented as multidimensional arrays of high-precision floating-point numbers. A significant feature of climate data is their temporal and spatial correlations, ie, the fact that values ??in surrounding ranges tend to be numerically close to each other. Most of the existed compression methods (such as patch-based matrix models) do not process the 3D data directly and are based on two dimensional matrices. Therefore these methods cannot simultaneously compress the data redundancy in both the spatial and temporal domains, and they can damage the correlation among different dimensions, resulting in a poor compression performance.

Although Adaptive_HGFDR is lossy compression, its error can be controlled to achieve a high compression ratio while meeting the compression error requirements, and the error of the compressed data is uniform.



DOCUMENTATION
-------------

Adaptive_HGFDR contains four different parts: a tensor compression library written in MATLAB; and a set of MATLAB header files that implement compressed text; data in MATLAB format; and a set of MATLAB examples.

htucker_1.2 and tensor_toolbox_2.6 are open source Matlab tensor libraries. Before running the code, add these two libraries to the environment. 

Adaptive_HGFDR.m, adaptive_rank2.m, error_rank2.m, and paring.m are the main codes of the Adaptive_HGFDR algorithm. This code can be used to achieve compression of climate model data.

"Data" file contains data for experiments used in the paper, including T temperature data, etc.
The data set includes Air Temperature data (T) stored as a 1024*512*26(latitude longitude height) tensor and 22 other attributes stored as a  1024*512*221(latitude longitude time) tensor from 1980-01 through 1998-05. the experimental data are dynamics simulation files obtained from Open Science Data Cloud. The data files are in the common NetCDF (network Common Data Form) format. Each file is broken down into year and month, containing all the variables for one month. The simulations were performed at approximately 1/3-degree spatial resolution, or a mesh size of 1024x512 for 2D (https://www.opensciencedatacloud.org/). The experimental data was downloaded in 2016 and may not be downloaded in OSDC now.


If you want to test the data, please run the test.m file. The test data is T in "data". The input and output of the function are described in the test.m file.
    
The main routines of our algorithms are read recursively into the MATLAB 2014b environment on a Windows 10 Workstation