# Read in .nc data and create a `GeoArray` or `GeoStack` from the data.
# I have been having difficulty with this in the notebook so thought I would try here with less clutter

using NCDatasets, GeoData, Glob, Plots, Dates

#First get the data from the .nc files

## NCdDataset. Note the path is different to the notebook.

SST_datapath = joinpath("..", "globalSST/sst")
globalSST_data = glob(joinpath(SST_datapath, "*.nc"))
globalSST_file = NCDataset(globalSST_data; aggdim = "time")

#At this point it looks to have correctly read in everything and the components of the data can be 
#accessed by

lat = globalSST_file["lat"]
lon =  globalSST_file["lon"]
time =  globalSST_file["time"]
sst =  globalSST_file["sst"]

variable(globalSST_file, "lon")
variable(globalSST_file, "lat")
#Have had issues reading this in so try to create a new full .nc filename. Bit of hack but not bad
write("full.nc", globalSST_file)

## GeoData attempt

## Here is some code from the examples that can be run

filename = joinpath("Task 2", "tos_O1_2001-2002.nc")
A = GeoArray(filename)
A[X()]
A[Ti(1:3:12)] |> plot
A.dims
#This all works now, the issue was having the wrong version of `GeoData.jl`.

## Now want to create a `GeoArray` from the "full.nc" file.
SSTglobal = GeoArray("Task 2/full.nc")
SSTglobal[X(1), Y(), Ti(1)] |> plot
##############################################################################################################

##ClimateBase attempt - won't even load the package..
#dimensions = (lon, lat, time)
#SSTglobal = ClimArray(globalSST_file["sst"], dimensions)