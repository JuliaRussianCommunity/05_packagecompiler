# #!/usr/bin/env julia --project=.
doc = """Naval Fate.

Usage:
  naval_fate.jl ship new <name>...
  naval_fate.jl ship <name> move <x> <y> [--speed=<kn>]
  naval_fate.jl ship shoot <x> <y>
  naval_fate.jl mine (set|remove) <x> <y> [--moored|--drifting]
  naval_fate.jl -h | --help
  naval_fate.jl --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
  --drifting    Drifting mine.

"""

# using DocOpt  # import docopt function
@isdefined(SampleAppDocOpt) || using DocOpt  # import docopt function

@show ARGS
args = docopt(doc, version=v"2.0.0"; exit_on_error = true)
@show args

@isdefined(SampleAppDocOpt) || using SampleAppDocOpt
greet(first(args["<name>"]))
