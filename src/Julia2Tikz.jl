module Julia2Tikz

include("./PlotStyles/PlotStyles.jl")

struct TikzAxis
	plots::AbstractVector{AbstractTikzPlot}
end

function TikzAxis()
	return TikzAxis([])
end

struct TikzFigure
	axes::AbstractVector{TikzAxis}
end

function TikzFigure()
	defaultAxis = TikzAxis()
	return TikzFigure([defaultAxis])
end

# Plotting routines
function plot(x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, plotType::Symbol=:scatter)
	plt = TikzFigure()
	plot!(plt, x, y, plotType)
	return plt
end

function plot!(figure::TikzFigure, x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, plotType::Symbol=:scatter)
	plot!(figure.axes[end], x, y)
end

# This currently only works with a scatter plot. How do we use multiple dispatch given a symbol argument to point to different plot types?
function plot!(axis::TikzAxis, x::AbstractVector{<: Real}, y::AbstractVector{<: Real}, plotType::Symbol=:scatter)
	thisPlot = scatter(x, y)
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
