
ext(::MIME"image/png") = ".png"
ext(::MIME"image/svg+xml") = ".svg"

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

function Base.show(io::IO, m::MIME"image/svg+xml", plt::RObject)
  @show f = tempname() * ext(m)
  #@show  width, height = get(io, :juno_plotsize,  [6, 5])

  R"""
    svg($f)
    show($plt)
    dev.off()
  """
  ## Copied from RCall.jl/src/ijulia.jl
  open(f) do f
      r = randstring()
      d = read(f, String)
      d = replace(d, "id=\"glyph" => "id=\"glyph"*r)
      d = replace(d, "href=\"#glyph" => "href=\"#glyph"*r)
      display(m,d)
  end
end

isggplot(plt::RObject) = rcopy(R"""ggplot2::is.ggplot($plt)""")

Base.showable(m::Union{MIME"image/png",MIME"image/svg+xml"}, plt::RObject) = is_ggplot(plt)