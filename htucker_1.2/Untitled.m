load cookies_matrices_2x2
A_handle = handle_lin_mat(A, {[], 0:100, 0:100, 0:100, 0:100});
M_handle = handle_inv_mat(A{1});
e = ones(101, 1); b_cell = {b, e, e, e, e};
b_tensor = htensor(b_cell);
opts.max_rank = 30; opts.rel_eps = 1e-10;
opts.maxit = 50; opts.tol = 0;
[x, norm_r] = cg_tensor(A_handle, M_handle, b_tensor, opts);
x_mean = full(ttv(x, {e,e,e,e}, [2 3 4 5])) / 101^4;
x_diff = x - htensor({x_mean,e,e,e,e});
x_var = diag(full(ttt(x_diff, x_diff, [2 3 4 5]))) / ( 101^4 - 1 );