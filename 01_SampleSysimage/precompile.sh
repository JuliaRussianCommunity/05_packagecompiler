mkdir -p sysimage
julia -e 'using Pkg; Pkg.add("PackageCompiler")'

julia --project=@. --startup-file=no -e 'using Pkg; Pkg.instantiate()'

# julia --project=@. --startup-file=no --trace-compile=sysimage/precompile.jl test/runtests.jl
julia --project=@. --startup-file=no --trace-compile=sysimage/precompile.jl -e 'import SampleSysimage'

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.create_sysimage(:SampleSysimage;
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)",
    sysimage_path="sysimage/custom_image.so",
    precompile_statements_file="sysimage/precompile.jl")
'
