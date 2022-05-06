struct TikzAxis <: AbstractTikzAxis
	plots::Vector{AbstractTikzPlot}
end

function TikzAxis()
	return TikzAxis([])
end

function EmptyTikzAxis()
	return TikzAxis()
end
