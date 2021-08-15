## Building standalone application

Use [`compile_app.sh`](compile_app.sh) and [`compile_app_with_test.sh`](compile_app_with_test.sh) to create applications with different ways of precompiling.

The module `SampleApp.jl` contains the method `table()` which is slow to first call. The scripts above generate executable applications in `bin/bin/SampleApp` and `bin_with_test/bin/SampleApp` paths.

The script `compile_app.sh` contains the code for building the app with default settings. The first call of the method `table()` is slow and almost the same as pure Julia script run. 
```sh
...
julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.audit_app(pwd())
PackageCompiler.create_app(pwd(), "bin";
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)", 
    filter_stdlibs=true)
'
```

At the same time, the script `compile_app_with_test.sh` contains `precompile_execution_file` argument with a test file which is covering all the functions of `SampleApp`. The first call of the method `table()` in that case is immediate. 
```sh
julia --project=@. --startup-file=no -e '
using PackageCompiler;
PackageCompiler.audit_app(pwd())
PackageCompiler.create_app(pwd(), "bin_with_test";
    cpu_target="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)", 
    filter_stdlibs=true,
    precompile_execution_file=["test/runtests.jl"])
'
```