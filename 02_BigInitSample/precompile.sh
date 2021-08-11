mkdir -p sysimage
julia -e 'using Pkg; Pkg.add("PackageCompiler")'
julia --project=@. --startup-file=no --trace-compile=sysimage/precompile.jl test/runtests.jl
julia --project=@. --startup-file=no -e 'using PackageCompiler; PackageCompiler.create_sysimage(:TwoGbCompilerIssue; sysimage_path="sysimage/TwoGbCompilerIssue.so", precompile_statements_file="sysimage/precompile.jl")'
