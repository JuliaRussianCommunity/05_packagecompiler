using JLD2

const tmp = joinpath(dirname(@__FILE__), "..", "tmp")
try
    mkdir(tmp)
catch
end

function cache_data(func::Function, filename::String, path::String, args...; kwargs...)
  local prepared = nothing
  if isfile(filename)
    jldopen(filename, "r") do file
      if haskey(file, path)
        prepared = file[path]
      end
    end
  end
  if isnothing(prepared)
    prepared = func(args...; kwargs...)
    jldopen(filename, "a+") do file
      file[path] = prepared
    end
  end
  return prepared
end
