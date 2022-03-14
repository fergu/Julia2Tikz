# Julia2Tikz
This is a work-in progress. The goal is a package with functionality similar to the matplotlib2tikz and matlab2tikz libraries. This package generates properly formatted Tikz files for inclusion in a LaTeX document via `\input{my_tikz_file.tikz}`.

Important Note: This package does not, and has no intent to, serve as an interactive plotting library akin to Plots.jl, etc. It also does not rely on an active LaTeX installation for any functionality. This package only generates the Tikz/PGFPlots formatted files - it is up to you to include them in your documents.
