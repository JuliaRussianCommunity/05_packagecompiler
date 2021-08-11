using Test
using SampleSysimage

@test isnothing(greet())
@test mul(2, 2) == 4
@test mul("2", "2") == "22"
@test !isnothing(table())
