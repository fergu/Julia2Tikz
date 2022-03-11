struct TikzPlotScatter <: AbstractTikzPlot
	x::AbstractVector{Number}
	y::AbstractVector{Number}
	linetype::String
	linecolor::String
	linewidth::Integer
end

function TikzPlotScatter(x::AbstractVector{<:Real}, y::AbstractVector{<:Real})
	return TikzPlotScatter(x, y, "", "black", 4)
end

function scatter(x::AbstractVector{<:Real}, y::AbstractVector{<:Real})
	return TikzPlotScatter(x, y)
end

function ToTikzString(plot::TikzPlotScatter)
	retString = ""
	retString *= "\\addplot[black, mark=*]\n"
	retString *= "coordinates\n{\n"
	for pt_i in range(1, length(plot.x))
		retString *= "($(plot.x[pt_i]), $(plot.y[pt_i]))\n"
	end
	retString *= "};\n"
	return retString
end
