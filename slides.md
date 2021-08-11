# Аспекты применения PackageCompiler

## Самарев Р. С.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Назначение PackageCompiler

* Sysimages - A sysimage is a file which, in a loose sense, contains a Julia session serialized to a file.
* Apps - With an "app" we here mean a "bundle" of files where one of these files is an executable and where this bundle can be sent to another machine while still allowing the executable to run.
* Libraries - Creating a library with PackageCompiler involves creating a custom system image with a couple of additional features to facilitate linking and use by external (non-Julian) programs–it's already a dynamic library.

[documentation](https://julialang.github.io/PackageCompiler.jl/dev/libs.html)
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Создание образа пакета

```julia
function create_sysimage(packages::Union{Symbol, Vector{Symbol}}=Symbol[];
                         sysimage_path::Union{String,Nothing}=nothing,
                         project::String=dirname(active_project()),
                         precompile_execution_file::Union{String, Vector{String}}=String[],
                         precompile_statements_file::Union{String, Vector{String}}=String[],
                         incremental::Bool=true,
                         filter_stdlibs=false,
                         replace_default::Bool=false,
                         base_sysimage::Union{Nothing, String}=nothing,
                         isapp::Bool=false,
                         julia_init_c_file=nothing,
                         version=nothing,
                         compat_level::String="major",
                         soname=nothing,
                         cpu_target::String=NATIVE_CPU_TARGET,
                         script::Union{Nothing, String}=nothing)
```
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Создание автономного приложения

```julia
function create_app(package_dir::String,
                    app_dir::String;
                    app_name=nothing,
                    precompile_execution_file::Union{String, Vector{String}}=String[],
                    precompile_statements_file::Union{String, Vector{String}}=String[],
                    incremental=false,
                    filter_stdlibs=false,
                    audit=true,
                    force=false,
                    c_driver_program::String=joinpath(@__DIR__, "embedding_wrapper.c"),
                    cpu_target::String=default_app_cpu_target())
```

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Создание динамической библиотеки

```julia
function create_library(package_dir::String,
                        dest_dir::String;
                        lib_name=nothing,
                        precompile_execution_file::Union{String, Vector{String}}=String[],
                        precompile_statements_file::Union{String, Vector{String}}=String[],
                        incremental=false,
                        filter_stdlibs=false,
                        audit=true,
                        force=false,
                        header_files::Vector{String} = String[],
                        julia_init_c_file::String=joinpath(@__DIR__, "julia_init.c"),
                        version=nothing,
                        compat_level="major",
                        cpu_target::String=default_app_cpu_target())
```

https://www.youtube.com/watch?v=c0IAP7NC2MU
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Шаблон для создания библиотеки

PkgTemplates.jl / PackageCompilerLib

```julia
using PkgTemplates

tpl = Template(;
    dir="~/code",
    plugins=[
        PackageCompilerLib(),
        Git(; manifest=true, ssh=true),
        Codecov(),
        TravisCI(; x86=true),
        Documenter{TravisCI}(),
    ],
)

tpl("MyPkg")
```
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

* * *

# Упаковка Docker-образа

[SimpleContainerGenerator.jl](https://github.com/JuliaContainerization/SimpleContainerGenerator.jl)
```julia
import SimpleContainerGenerator

mkpath("my_image_name")
cd("my_image_name")

pkgs = [
    "Foo", # Replace Foo, Bar, Baz, etc. with the names of actual packages that you want to use
    "Bar",
    "Baz",
]
julia_version = v"1.4.0"

SimpleContainerGenerator.create_dockerfile(pkgs;
                                           julia_version = julia_version,
                                           output_directory = pwd())

run(`docker build -t my_docker_username/my_image_name .`)
```

* * *
