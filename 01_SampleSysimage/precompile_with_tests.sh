mkdir -p sysimage_tests
julia -e 'using Pkg; Pkg.add("PackageCompiler")'

julia --project=@. --startup-file=no -e 'using Pkg; Pkg.instantiate()'

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.create_sysimage(:SampleSysimage;
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)",
    sysimage_path="sysimage_tests/custom_image.so",
    precompile_execution_file=["test/runtests.jl"])
'

exit 0

######### alternative way

julia --project=@. --startup-file=no --trace-compile=sysimage_tests/precompile.jl test/runtests.jl

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.create_sysimage(:SampleSysimage;
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)",
    sysimage_path="sysimage_tests/custom_image.so",
    precompile_statements_file="sysimage_tests/precompile.jl")
'
