using Test
using GGPlot2, DataFrames

df_string = DataFrame(x = randn(10), y=randn(10), z1=rand(["a"; "b"], 10))

plt = ggplot(df_string) + geom_point(aes(x=:x, y=:y, color=:z1))

@test GGPlot2.isggplot(plt)


