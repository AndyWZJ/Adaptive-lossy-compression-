% htucker toolbox
% Version 1.2
%
% Toolbox for tensors in hierarchical Tucker decomposition (HTD)
%
% Functions.
%   truncate       - Truncate full tensor/htensor/CP to htensor.
%
% Example tensors.
%   gen_invlaplace - htensor for approx. inverse of Laplace-like
%   matrix.htensor大约。逆拉普拉斯状基质。
%   gen_laplace    - htensor for Laplace-like matrix.htensor拉普拉斯样基质
%   gen_sin_cos    - Function-valued htensor for sine and cosine.
%   htenones       - htensor with all elements one.值为1全张量
%   htenrandn      - Random htensor.随机层次张量
%   laplace_core   - Core tensor for Laplace operator.核心张量拉普拉斯算子。
%   reciproc_sum   - Function-valued tensor for 1/(xi_1+ ... +xi_d)
%   
% Auxiliary functions for full tensors.
%   dematricize    - Determine (full) tensor from matricization.
%   diag3d         - Return third-order diagonal tensor.返回三阶角张量
%   isindexvector  - Check whether input is index vector.检查是否输入索引向量。
%   khatrirao_aux  - Khatri-Rao product.
%   khatrirao_t    - Transposed Khatri-Rao product.转了Khatri-Rao积
%   matricize      - Return matricization of (full) tensor.
%                   turns a tensor (a multi-dimensional array) into a matrix
%   spy3           - Plot sparsity pattern of order-3 tensor.
%   ttm            - N-mode multiplication of (full) tensor with matrix
%   ttt            - Tensor times tensor (full tensors).
%
% Test
%   test_functions - Simple test script to check for obvious bugs.
%
%
% --------------------------------------------------------------------------
%                                   @htensor/
% --------------------------------------------------------------------------
%
% Construction of htensor objects.
%   htensor            - Construct a tensor in HTD and return htensor object.
%                           构造一个层次张量
%   define_tree        - Define dimension tree.
%
% Basic functionality.
%   cat                - Concatenate two htensor objects.
                        %连接两个层次张量
%   change_dimtree     - Change dimension tree of htensor.更改htensor的维度树
%   change_root        - Change root of the dimension tree.
%   check_htensor      - Check internal consistency of htensor.
%                           检查htensor的内部一致性。
%   conj               - Complex conjugate of htensor.
%   ctranspose         - Not defined for htensor.
%   disp               - Command window display of htensor.  在命令行显示层次张量
%   display            - Command window display of htensor.
%   disp_all           - Command window display of dimension tree of htensor.
%   end                - Last index in one mode of htensor.
%   equal_dimtree      - Compare dimension trees of two htensor objects.比较两个张量的维度
%   full               - Convert htensor to a (full) tensor.生成全张量
%   full_block         - Return subblock of htensor as a (full) tensor.
%   full_leaves        - Convert leaf matrices U to dense matrices.
%   ipermute           - Inverse permute dimensions of htensor.
%   isequal            - Check whether two htensors are equal.判断两个张量是否相同
%   mrdivide           - Scalar division for htensor.
%   mtimes             - Scalar multiplication for htensor.
%   ndims              - Order (number of dimensions) of htensor.计算总维度
%   ndofs              - Number of degrees of freedom in htensor.矩阵的自由度应该是矩阵所包含的可变参数的个数，即它做变换的角度参量个数
%   norm               - Norm of htensor.
%   norm_diff          - Norm of difference between htensor and full tensor.
%   nvecs              - Dominant left singular vectors for matricization of htensor.
%   permute            - Permute dimensions of htensor.
%   plot_sv            - Plot singular value tree of htensor.   htensor的奇异值树
%   rank               - Hierarchical ranks of htensor.
%   singular_values    - Singular values for matricizations of htensor.奇异值htensor的matricizations。
%   size               - Size of htensor.
%   sparse_leaves      - Convert leaf matrices U to sparse matrices.
%   spy                - Plot sparsity pattern of the nodes of htensor.
%   squeeze            - Remove singleton dimensions from htensor.
%   subsasgn           - Subscripted assignment for htensor.
%   subsref            - Subscripted reference for htensor.
%   subtree            - Return all nodes in the subtree of a node.
%   transpose          - Not defined for htensor.
%   uminus             - Unary minus (-) of htensor.
%   uplus              - Unary plus for htensor.
%
% Operations with htensor objects.
%   elem_mult          - Approximate element-by-element multiplication for htensor.
%   innerprod          - Inner product for htensor. 两个张量的内积
%   minus              - Binary subtraction for htensor. -
%   plus               - Binary addition for htensor. +
%   power              - Element-by-element square for htensor. 指数
%   times              - Element-by-element multiplication for htensor. 
%   ttm                - N-mode multiplication of htensor with matrix.
%   ttt                - Tensor-times-tensor for htensor.
%   ttv                - Tensor-times-vector for htensor.
%
% Orthogonalization and truncation.
%   gramians           - Reduced Gramians of htensor in orthogonalized HTD.
%   gramians_cp        - Reduced Gramians of CP tensor.
%   gramians_nonorthog - Reduced Gramians of htensor.
%   gramians_sum       - Reduced Gramians for sum of htensor objects.
%   left_svd_gramian   - Left singular vectors and values from Gramian.
%   left_svd_qr        - Left singular vectors and values.
%   orthog             - Orthogonalize HTD of htensor.
%   trunc_rank         - Return rank according to user-specified parameters.
%   truncate_cp        - Truncate CP tensor to lower-rank htensor.
%   truncate_ltr       - Truncate full tensor to htensor, leaves-to-root.
%   truncate_nonorthog - Truncate htensor to lower-rank htensor.
%   truncate_rtl       - Truncate full tensor to htensor, root-to-leaves.
%   truncate_std       - Truncate htensor to lower-rank htensor.
%   truncate_sum       - Truncate sum of htensor objects to lower-rank htensor.
%
% Linear Operators.
%   apply_mat_to_mat   - Applies an operator in HTD to another operator in HTD.
%   apply_mat_to_vec   - Applies an operator in HTD to htensor.
%   full_mat           - Full matrix represented by an operator in HTD.
%   innerprod_mat      - Weighted inner product for htensor.
% 
% Interface with Tensor Toolbox
%   ktensor_approx     - Approximation of htensor by ktensor.
%   mttkrp             - Building block for approximating htensor by ktensor.
%   ttensor            - Convert htensor into a Tensor Toolbox ttensor.张量转换
%
%
% --------------------------------------------------------------------------
%                                   examples/
% --------------------------------------------------------------------------
%
% Demos:
%   demo_basics           - Demonstration of basic htensor functionality.示范的基本htensor功能。

%   demo_constructor      - Demonstration of htensor constructors.htensor构造的示范
%   demo_elem_reciprocal  - Demonstration of element-wise reciprocal.演示单元明智的倒数。
%   demo_function         - Demonstration of htensor function approximation.示范htensor函数逼近。
%   demo_invlaplace       - Demonstration of approximate inverse Laplace.示范近似逆拉普拉斯。
%   demo_operator         - Demonstration of operator-HTD format.示范运营-HTD格式。
%
% Examples:
%   example_cancellation  - Cancellation in tan(x) + 1/x - tan(x).简单的运算
%   example_cancellation2 - Cancellation in exp(-x^2) + sin(x)^2 + cos(x)^2.
%   example_cookies       - Apply CG method to a parametric PDE.

%   example_maxest        - Example for computing element of
%                           maximal absolute value.
%   example_spins         - Demonstration of operator-HTD for 1D spin system.
%   example_truncation    - Comparison of speed for different
%                           truncation methods.
%
% Functions:
%   cg_tensor             - Truncated Conjugate Gradient method for htensor.
%   elem_reciprocal       - Iterative computation of elementwise
%                           reciprocal for htensor.
%   handle_inv_mat        - Function handle to Kronecker structured matrix multiplication.
%   handle_lin_mat        - Function handle to Kronecker structured matrix multiplication.
%   maxest                - Approximate element of maximal absolute value.
%
% MAT-files:
%   cookies_matrices_2x2  - FE discretization of parametric PDE
%                           with 4 parameters
%   cookies_matrices_3x3  - FE discretization of parametric PDE
%                           with 9 parameters


% C. Tobler and D. Kressner, EPF Lausanne
% FreeBSD License, see COPYRIGHT.txt
