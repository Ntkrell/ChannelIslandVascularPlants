#########requirements##############
#list of genus, species names query idigbio
#limit by lat/long bounding box

#Anacapa Island, Ventura County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.043200, lon=-119.471390), bottom_right=list(lat=33.973352, lon=-119.317977)))

#Santa Cruz Island, Santa Barbara County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.103252, lon=-119.943268), bottom_right=list(lat=33.882060, lon=-119.510982)))

#Santa Rosa Island, Santa Barbara County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.066196, lon=-120.251608), bottom_right=list(lat=33.879497, lon=-119.954113)))

#Santa Barbara Island, Santa Barbara County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=33.494456, lon=-119.061826), bottom_right=list(lat=33.456352, lon=-119.010264)))

#San Miguel Island, Santa Barbara County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.093612, lon=-120.494533), bottom_right=list(lat=33.983255, lon=-120.286866)))

#San Nicholas Island, Ventura County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=33.305983, lon=-119.583882), bottom_right=list(lat=33.197401, lon=-119.416234)))

#Santa Catalina Island, Los Angeles County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=33.527942, lon=-118.643121), bottom_right=list(lat=33.259973, lon=-118.267602)))

#San Clemente Island, Los Angeles County
#query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=33.053354, lon=-118.640136), bottom_right=list(lat=32.757320, lon=-118.314609)))


#counts by species, filtered by island name
######################
#kseltmann (enicospilus@gmail.com) April 2017

install.packages("devtools")
install_github("idigbio/ridigbio")
#install.packages("ridigbio")

library(devtools)
library(ridigbio)

#set working directory
setwd("/Library/WebServer/Documents/ChannelIslandsVascularPlants")

#read tab delimited file with headers
vascular_plants <- read.delim("ChannelIslandsFlora-speciesTEST.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "\"")

#create a unique list
vascular_plants <- unique(vascular_plants)

#check number of rows
nrow(vascular_plants)

#check output
head(vascular_plants)

#creates separate spreadsheet for all genus species in tab delimited list
for (x in vascular_plants$id){
  subsetHosts <- subset(vascular_plants, id == x)
  g <- subsetHosts$genus
  sE <- subsetHosts$specificepithet
  query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.103252, lon=-119.943268), bottom_right=list(lat=33.882060, lon=-119.510982)))
  df <- idig_search_records(rq=query,fields = c('family','genus','specificepithet','stateprovince','county','locality','uuid'))
  
  #query <- list(genus=g,specificepithet=sE,geopoint=list(type="geo_bounding_box", top_left=list(lat=34.103252, lon=-119.943268), bottom_right=list(lat=33.882060, lon=-119.510982)))
  #df <- c(idig_count_records(rq=query),g,sE)
  
  #create one giant file
  write.table(df, file="all.tsv", sep="\t", append = TRUE , row.names = F, col.names = F)
}

??write.table

#insert into mysql database using load data all.tsv

#################################
#################################


## information below about the idigbio api and ridigbio
#https://github.com/cran/ridigbio

#returns all searchable fields
idig_meta_fields()
idig_view_records()

#find all functions in package
lsp <- function(package, all.names = FALSE, pattern) 
{
  package <- deparse(substitute(package))
  ls(
    pos = paste("package", package, sep = ":"), 
    all.names = all.names, 
    pattern = pattern
  )
}

lsp(ridigbio)

