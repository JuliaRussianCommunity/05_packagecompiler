# Sample of sysimage issue with huge static initilized variables

See [`precompile.sh`](precompile.sh) script which is creating sysimage.

Full code of the module see at [src/TwoGbCompilerIssue.jl](src/TwoGbCompilerIssue.jl).

There is a specific initialization of global scope variable/constants. All the data activated directly in a module's global scope is stored into sysimage as is. But Julia supports 2GB sysimage only. The following sample breaks PackageCompiler due to exceeding that restriction.
```julia
module TwoGbCompilerIssue
# ...
const embtable = @time cache_data(joinpath(tmp, "fasttext.jld2"), "embeddings") do
  load_embeddings(FastText_Text)
end
const embsize = size(embtable.embeddings)[1]

const get_word_index = Dict(word=>ii for (ii,word) in enumerate(embtable.vocab))
# ...
end
```

The correct way is to initialize huge data structures in `__init__()` method.
```julia
module TwoGbCompilerIssue
# ...
embtable = nothing
embsize = nothing
get_word_index = nothing

function __init__()
  global embtable = @time cache_data(joinpath(tmp, "fasttext.jld2"), "embeddings") do
    load_embeddings(FastText_Text)
  end
  global embsize = size(embtable.embeddings)[1]
  global get_word_index = Dict(word=>ii for (ii,word) in enumerate(embtable.vocab))

# ...
end
```
