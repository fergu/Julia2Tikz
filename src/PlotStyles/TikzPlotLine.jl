struct TikzPlotLine <: AbstractTikzPlot
	x::AbstractVector{Number}
	y::AbstractVector{Number}
	attributes::Dict{String, String}
end


function line!(axis::TikzAxis, x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, attributes::Dict{String,String}=Dict{String,String}())
	push!(axis.plots, TikzPlotLine(x, y, attributes))
	return axis
end

function line!(figure::TikzFigure, x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, attributes::Dict{String,String}=Dict{String,String}())
	line!(figure.axes[begin], x, y, attributes)
	return figure
end

function line(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, attributes::Dict{String,String}=Dict{String,String}())
	return line!(EmptyTikzFigure(), x, y, attributes)
end

function ToTikzString(plot::TikzPlotLine)
	retString = ""
	retString *= "\\addplot[\n"
	for (k,v) in plot.attributes
		retString *= "$k = $v,\n"
	end
	retString *= "]\n"
	retString *= "coordinates\n{\n"
	for pt_i in range(1, length(plot.x))
		retString *= "($(plot.x[pt_i]), $(plot.y[pt_i]))\n"
	end
	retString *= "};\n"
	return retString
end
