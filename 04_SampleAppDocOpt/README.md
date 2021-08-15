# Application with DocOpt

[DocOpt](https://github.com/docopt/DocOpt.jl) is a parser of command-line arguments with a simple language to define allowable arguments and default values.

The specifics of DocOpt use in Julia, the code of the parser should be activated first. As Julia executes a script file line by line, the code  is performed immediately after declaration if it is required. That allows to parse command-line arguments only, show help and stop execution without awaiting loading of all the module dependencies. E.g. `using Plots;` or `using DataFrames;` might be really slow.

The issue of the application building is a conflict of styles. The script execution consumes activating of DocOpt and parsing arguments first and activate the module next - see [run.jl](src/run.jl). The executable application must be written with the only entry point `julia_main`, and all the dependencies must be included.

The workaround is surrounding the `run.jl` script by a function - [SampleAppDocOpt.jl](src/SampleAppDocOpt.jl).
```julia
function real_main()
    include("src/run.jl")
end
```

The disadvantage of that approach is the on-fly compiling of the `run.jl` code despite the binary file presence. And the file `run.jl` must be changed to avoid dynamic modules loading:
```julia
@isdefined(SampleAppDocOpt) || using DocOpt`
```

So, don't expect performance higher than pure script code `julia run.jl` in that case.
The way to fix it is to re-use the code of `run.jl` but place the DocOpt related code into `julia_main()` directly. And, finally, the code for building an executable app should be without a sequence of computable operations in global scope of a module but rather be structured by functions with the only entry point.
