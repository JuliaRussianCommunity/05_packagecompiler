module TwoGbCompilerIssue

import Embeddings: load_embeddings, FastText_Text
import WordTokenizers: tokenize
import Distances: cosine_dist

include("utils.jl")

ENV["DATADEPS_ALWAYS_ACCEPT"] = true

# const embtable = @time cache_data(joinpath(tmp, "fasttext.jld2"), "embeddings") do
#   load_embeddings(FastText_Text)
# end
# const embsize = size(embtable.embeddings)[1]

# const get_word_index = Dict(word=>ii for (ii,word) in enumerate(embtable.vocab))

function get_embedding(word)
  ind = get(get_word_index, word, -1)
  return ind == -1 ? zeros(embsize) : embtable.embeddings[:,ind]
end

function vectorize(str::String)
  local tokens = str |> tokenize
  isempty(tokens) ? zeros(embsize) : mapreduce(get_embedding, +, tokens)
end

function calc_distance(strings::Vector{String}, point::String)
  db_v = strings .|> vectorize
  point_v = vectorize(point)

  res = map(v -> cosine_dist(v, point_v), db_v) |>
  v_list -> map(item -> (id = item[begin], dist = item[end]), enumerate(v_list))

  map(k -> (strings[k.id], k.dist),  res) |>
      l -> filter(((s, w),) -> w < 0.7, l)
end


embtable = nothing
embsize = nothing
get_word_index = nothing

function __init__()
  global embtable = @time cache_data(joinpath(tmp, "fasttext.jld2"), "embeddings") do
    load_embeddings(FastText_Text)
  end
  global embsize = size(embtable.embeddings)[1]
  global get_word_index = Dict(word=>ii for (ii,word) in enumerate(embtable.vocab))
end

end # module
