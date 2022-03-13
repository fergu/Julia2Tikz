struct TikzFigure <: AbstractTikzFigure
	axes::Vector{AbstractTikzAxis}
end

function TikzFigure()
	return TikzFigure([])
end
