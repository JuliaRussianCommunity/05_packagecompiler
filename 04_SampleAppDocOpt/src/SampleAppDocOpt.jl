module SampleAppDocOpt
using DocOpt # must be here due to binary app compiling

export greet

greet() = greet("World")
greet(name) = println("Hello $(name)!")

global_initialized_string = join(string.(1:10), " ")
println("global_initialized_string from global space: ", string(global_initialized_string))

function __init__()
    println("global_initialized_string from init: ", string(global_initialized_string))
    println(string("This is a call from init: ", @__MODULE__))
end

# # Base.@ccallable # obsolete
function julia_main()::Cint
    println("julia_main")
    try
        real_main()
    catch
        Base.invokelatest(Base.display_error, Base.catch_stack())
        return 1
    end
    return 0
end

function real_main()
    include("src/run.jl")
end

if abspath(PROGRAM_FILE) == @__FILE__
    real_main()
end

end # module
