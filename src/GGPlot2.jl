module GGPlot2

__precompile__(false)

using FileIO
using ImageShow
using Reexport
@reexport using RCall
__temp__ = rimport("ggplot2")
@reexport using .__temp__

include("io.jl")

end # module
