module Julia2Tikz

include("./TikzTypes.jl")
include("./TikzAxis.jl")
include("./TikzFigure.jl")
include("./PlotStyles/PlotStyles.jl")

# Mapping between the plot_type argument and underlying function when calling plot()
plot_type_map = Dict{Symbol, Function}(
										:scatter => scatter
									   )

# Plotting routines
function plot(x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, attributes::Dict{String,String}; plotType::Symbol=:scatter)
	plt = TikzFigure()
	defaultAxis = TikzAxis()
	push!(plt.axes, defaultAxis)
	plot!(plt, x, y, attributes, plotType=plotType)
	return plt
end

function plot!(figure::AbstractTikzFigure, x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, attributes::Dict{String,String}; plotType::Symbol=:scatter)
	plot!(figure.axes[end], x, y, attributes, plotType=plotType)
end

# This currently only works with a scatter plot. How do we use multiple dispatch given a symbol argument to point to different plot types?
function plot!(axis::AbstractTikzAxis, x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, attributes::Dict{String,String}; plotType::Symbol=:scatter)
	thisPlot = scatter(x, y, attributes)
	push!(axis.plots, thisPlot)
end

function saveTikz(figure::TikzFigure, fileName::String)
	open(fileName, "w") do f
		write(f, "\\begin{tikzpicture}\n")
		for ax in figure.axes
			write(f, "\\begin{axis}[\n]\n")
			for line in ax.plots
				write(f, ToTikzString(line))
			end
			write(f, "\\end{axis}\n")
		end
		write(f, "\\end{tikzpicture}\n")
	end
end

end
