# Read in .nc data and create a `GeoArray` or `GeoStack` from the data.
# I have been having difficulty with this in the notebook so thought I would try here with less clutter

#=
 The work around I have for this is a bit of a hack but I think is the cleanest way given how Xg it took
 First read in the data using NCDataset. This is quite easy just not sure if this is where the error is occuirng.
 Next get the data and dimensions from the data.
 Then form the `GeoArray(sst, dimensions)`.
 Does not have as much metadata etc but can always return to the NCDataset if need be
=#
using NCDatasets, GeoData, Glob, Plots, Dates, Rasters

#First get the data from the .nc files

## NCdDataset. Note the path is different to the notebook.

SST_datapath = joinpath("..", "globalSST/sst") 
globalSST_data = glob(joinpath(SST_datapath, "*.nc"))
globalSST_file = NCDataset(globalSST_data; aggdim = "time")

#At this point it looks to have correctly read in everything and the components of the data can be 
#accessed by

Y = globalSST_file["Y"][:]
X =  globalSST_file["X"][:]
timelength =  globalSST_file["time"][:]
sst =  globalSST_file["sst"]

DimensionalData.Dimensions.@dim Y "Yitude (degrees north)"
DimensionalData.Dimensions.@dim X "Xgitude (degrees east)"
X = 0:2:358
Y = -88:2:88
dimensions = (X(X), Y(Y), Ti(timelength))

#Have had issues reading this in so try to create a new full .nc filename. Bit of hack but not bad.
#No Xger need this with the new method.
#write("full.nc", globalSST_file)

## GeoData attempt

## Here is some code from the examples that can be run
#This all works and shows how you can plot multiple things etc.
filename = joinpath("Task 2", "tos_O1_2001-2002.nc")
A = GeoArray(filename)
A[X()]
A[Ti(1:3:12)] |> plot
A.dims

## With the Rasters package

A = Raster(filename)
A[Ti(1:3:12)] |> plot

## Now want to create a `GeoArray` from the "full.nc" file.
#SSTglobal = GeoArray("Task 2/full.nc")
SSTglobal = GeoArray(sst, dimensions, name = :SeaSurfaceTemperture)
SSTglobal = Raster(sst, dimensions, name = :SeaSurfaceTemperture)

## Try some plots which now work with the 
SSTglobal[X(), Y(), Ti(1)] |> plot

plot(SSTglobal[Ti(1)], xlabel = "Yitude (degrees north)")

SSTglobal[X(Between(120, 280)), Y(At(0)), Ti(1)] |> plot

test = SSTglobal[X(Between(120, 280)), Y(At(0))] 

test_plot = test |> heatmap
#or
heatmap(test, color = :balance)

compareplot = heatmap(120:2:280, timelength, test', 
                title = "Yitude (degrees north): 0",
                xlabel = "Xgitude (degrees east)",
                ylabel = "Time",
                colorbar_title  = "SeaSurfaceTemperture")

