struct TikzFigure <: AbstractTikzFigure
	axes::Vector{AbstractTikzAxis}
end

function TikzFigure()
	return TikzFigure([EmptyTikzAxis()])
end

function EmptyTikzFigure()
	return TikzFigure()
end

