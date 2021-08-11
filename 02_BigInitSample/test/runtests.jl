using TwoGbCompilerIssue
using Test

@testset "TwoGbCompilerIssue.jl" begin
  strings = [
    "Java", "Java programmer", "Julia language", "Julia programmer",
    "cpp", "programming", "Ruby", "Ada",
    "carrot", "beet", "cucumber", "Cucumber"
  ];

  res = TwoGbCompilerIssue.calc_distance(strings, strings[1])

  @assert !isempty(res)

  @show res
end

