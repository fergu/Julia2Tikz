struct TikzPlotFormula <: AbstractTikzPlot
	x::AbstractVector{Number}
	y::AbstractVector{Number}
	attributes::Dict{String, String}
end

# A fomula specifying only a function of the form y = f(x)
function formula(y::String, attributes::Dict{String,String}=Dict())
	
end

# A fomula with a range of x values and y specified as a fomula
function formula(x::AbstractVector{<:Real}, y::String, attributes::Dict{String,String}=Dict())
	return TikzPlotScatter(x, y, attributes)
end

function ToTikzString(plot::TikzPlotScatter)
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
