exec xvlog -sv -f axil_dpmem_files.f;
exec xelab axil_tb -timescale 1ns/10ps;
exec xsim axil_tb -runall