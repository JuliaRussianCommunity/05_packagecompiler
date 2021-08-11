module SampleSysimage
using DataFrames

export greet, mul, table

greet() = println("Hello World!")

# nonambiguous method for different types
mul(x, y) = x * y

function table()
    df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
    println(df)
    df
end

global_initialized_string = let
    println("initialize global value")
    join(string.(1:10), " ")
end

println("global_initialized_string from global space: ", string(global_initialized_string))

function __init__()
    println("global_initialized_string from __init__: ", string(global_initialized_string))
    println(string("This is a call from __init__: ", @__MODULE__))
end

end # module
