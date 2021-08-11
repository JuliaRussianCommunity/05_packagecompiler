julia -e 'using Pkg; Pkg.add("PackageCompiler")'

julia --project=@. --startup-file=no -e 'using Pkg; Pkg.instantiate()'

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.audit_app(pwd())
PackageCompiler.create_app(pwd(), "bin_with_test";
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)", 
    filter_stdlibs=true,
    precompile_execution_file=["test/runtests.jl"])
'
