ZFP
===

INTRODUCTION
------------
zfp is an open source C/C++ library for compressed numerical arrays that support high throughput read and write random access. zfp also supports streaming compression of integer and floating-point data, e.g., for applications that read and write large data sets to and from disk.

zfp was developed at Lawrence Livermore National Laboratory and is loosely based on the algorithm described in the following paper:

Peter Lindstrom
"Fixed-Rate Compressed Floating-Point Arrays"
IEEE Transactions on Visualization and Computer Graphics
20(12):2674-2683, December 2014
doi:10.1109/TVCG.2014.2346458

zfp was originally designed for floating-point arrays only, but has been extended to also support integer data, and could for instance be used to compress images and quantized volumetric data. To achieve high compression ratios, zfp uses lossy but optionally error-bounded compression. Although bit-for-bit lossless compression of floating-point data is not always possible, zfp is usually accurate to within machine epsilon in near-lossless mode.

zfp works best for 2D and 3D arrays that exhibit spatial correlation, such as continuous fields from physics simulations, images, regularly sampled terrain surfaces, etc. Although zfp also provides a 1D array class that can be used for 1D signals such as audio, or even unstructured floating-point streams, the compression scheme has not been well optimized for this use case, and rate and quality may not be competitive with floating-point compressors designed specifically for 1D streams.

zfp is freely available as open source under a BSD license, as outlined in the file 'LICENSE'. For more information on zfp and comparisons with other compressors, please see the zfp website. For questions, comments, requests, and bug reports, please contact Peter Lindstrom.

Full documentation is available online via 'https://zfp.readthedocs.io/en/release0.5.3/index.html' . A PDF version is also available via 'https://readthedocs.org/projects/zfp/downloads/pdf/release0.5.3/'.

The download and description of the file can be obtained through website 'https://github.com/LLNL/zfp/tree/develop'.

INSTALLATION
------------
zfp consists of three distinct parts: a compression library written in C; a set of C++ header files that implement compressed arrays; and a set of C and C++ examples. The main compression codec is written in C and should conform to both the ISO C89 and C99 standards. The C++ array classes are implemented entirely in header files and can be included as is, but since they call the compression library, applications must link with libzfp.

On Linux, macOS, and MinGW, zfp is easiest compiled using gcc and gmake. CMake support is also available, e.g. for Windows builds. See below for instructions on GNU and CMake builds.

zfp has successfully been built and tested using these compilers:

gcc versions 4.4.7, 4.7.2, 4.8.2, 4.9.2, 5.4.1, 6.3.0
icc versions 12.0.5, 12.1.5, 15.0.4, 16.0.1, 17.0.0, 18.0.0
clang version 3.6.0
xlc version 12.1
MinGW version 5.3.0
Visual Studio versions 14.0 (2015), 14.1 (2017)

NOTE: zfp requires 64-bit compiler and operating system support.

Simple Operation Method
------------
1.Open the ZFP_data_processing.m file and import the required data.
2.Run 4-8 lines of code in the ZFP_data_processing.m file and export the data to a bin format file.
3.Unzip the zfp-0.5.3.rar file
4.Perform cmake on the zfp-0.5.3.rar file£¨build, build1, build2, build3, build4 are the previous cmake files, you can build a build5£©
5.Open build5, and open ZFP.sln
6.Find inplace.cpp in the solution explorer and run it£¨The main parameters and operation can be completed in this file£©
7.Run 15-20 lines of code in the ZFP_data_processing.m file. At this time, data_zfp represents the data compressed by zfp.

In inplace.cpp, there are several important parameters:
1.tolerance£º A parameter that controls compression error and accuracy. The larger the value, the greater the error and the greater the compression ratio. (See formula 5 in the paper for compression ratio)
2.T£ºBecause before using the ZFP algorithm, the three-dimensional data is processed into two-dimensional *n, and the two-dimensional data is converted into bin format data, a total of n. For example, a 1024*512*26 data is processed into 26 1024*512 bin format files, and T is 26.
3.Input the address of two-dimensional data in the format of bin file in line 140.
4.The output is the address of the compressed txt file.
