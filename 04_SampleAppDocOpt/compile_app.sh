# julia -e 'using Pkg; Pkg.add("PackageCompiler")'

julia --project=@. --startup-file=no -e 'using Pkg; Pkg.instantiate()'

julia --project=@. --startup-file=no --trace-compile=build/precompile_statements.jl src/run.jl ship new Aurora

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.audit_app(pwd())
PackageCompiler.create_app(pwd(), "bin";
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)", 
    filter_stdlibs=true,
    precompile_statements_file=["build/precompile_statements.jl"])
'

exit 0
########

julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.audit_app(pwd())
PackageCompiler.create_app(pwd(), "bin";
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)", 
    filter_stdlibs=true,
    precompile_execution_file=["src/run.jl"])
' ship new Aurora
