struct TikzPlotScatter <: AbstractTikzPlot
	x::AbstractVector{Number}
	y::AbstractVector{Number}
	named_attributes::Dict{String, String} # Attributes that are defined using name = value syntax (I.E line width = 3)
	value_attributes::Vector{String} # Attributes that are specified by simply being present (I.E 'only marks' for a scatter plot)
end

function scatter!(axis::TikzAxis, x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, named_attributes::Dict{String,String}=Dict{String,String}(), value_attributes::Vector{String}=Vector{String}(["only marks"]))
	push!(axis.plots, TikzPlotScatter(x, y, named_attributes, value_attributes))
	return axis
end

function scatter!(figure::TikzFigure, x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, named_attributes::Dict{String,String}=Dict{String,String}(), value_attributes::Vector{String}=Vector{String}(["only marks"]))
	scatter!(figure.axes[begin], x, y, named_attributes, value_attributes)
	return figure
end

function scatter(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, named_attributes::Dict{String,String}=Dict{String,String}(), value_attributes::Vector{String}=Vector{String}(["only marks"]))
	return scatter!(EmptyTikzFigure(), x, y, named_attributes, value_attributes)
end

function ToTikzString(plot::TikzPlotScatter)
	retString = ""
	retString *= "\\addplot[\n"
	for (k,v) in plot.named_attributes
		retString *= "$k = $v,\n"
	end
	for a in plot.value_attributes
		retString *= "$a,\n"
	end
	retString *= "]\n"
	retString *= "coordinates\n{\n"
	for pt_i in range(1, length(plot.x))
		retString *= "($(plot.x[pt_i]), $(plot.y[pt_i]))\n"
	end
	retString *= "};\n"
	return retString
end
