
#rdevicefun(m::MIME"image/png") = @rget png
#rdevicefun(m::MIME"image/svg+xml", f) = R"svg($f)"
ext(::MIME"image/png") = ".png"
#ext(::MIME"image/svg+xml") = ".svg"

function Base.show(io::IO, m::MIME"image/png", plt::RObject)
  @show f = tempname() * ext(m)
  @show  width, height = get(io, :juno_plotsize,  [6*72, 5*72])

  R"""
    png($f, width=$width, height=$height, units="px")
    show($plt)
    dev.off()
  """
  show(io, m, load(f))
end

Base.showable(m::MIME"image/png", plt::RObject) = rcopy(R"""ggplot2::is.ggplot($plt)""")
