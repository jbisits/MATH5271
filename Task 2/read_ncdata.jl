# Read in .nc data and create a `GeoArray` or `GeoStack` from the data.
# I have been having difficulty with this in the notebook so thought I would try here with less clutter

using NCDatasets, GeoData, Glob

## NCdDataset. Note the path is different to the notebook.

SST_datapath = joinpath("..", "globalSST/sst")
globalSST_data = glob(joinpath(SST_datapath, "*.nc"))
globalSST_file = NCDataset(globalSST_data; aggdim = "time")

#At this point it looks to have correctly read in everything.