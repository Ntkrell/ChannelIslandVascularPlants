#########requirements##############
#list of genus, species names query idigbio
#limit by channel island, wildcard search
#Santa Cruz Island, Santa Barbara County
#Anacapa Island, Ventura County
#Santa Barbara Island, Santa Barbara County
#San Miguel Island, Santa Barbara County
#San Nicholas Island, Ventura County
#Santa Catalina Island, Los Angeles County
#San Clemente Island, Los Angeles County
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
  sT <- "California"
  cO <- "Santa Barbara"
  loc <- "San Miguel"
  
  query <- list(genus=g,specificepithet=sE,stateProvince=sT,county=cO,locality=loc)
}

query <- list("verbatimlocality"=list("type"="exists"), "verbatimlocality"="san miguel island")
  df <- idig_search_records(rq=query,limit=10)
head(df)
??idig_search
??idig_search_records

  #no georeference remarks? or establishmentMeans?
  allHosts <- rq[c("uuid","institutioncode","catalognumber","locality","geopoint.lat","geopoint.lon","country","stateprovince","county","municipality","coordinateuncertainty","family","genus","specificepithet","infraspecificepithet","scientificname")]
  
  #colnames(allHosts) <- c("coreid","institutioncode","catalogNumber","locality", "decimalLatitude", "decimalLongitude", "country", "stateProvince", "county", "municipality","coordinateUncertaintyInMeters","family","genus","specificEpithet","infraspecificEpithet","scientificName")
  
  title <- paste(g,"_",sE,'.tsv',sep="")
  
  #create a separate file for each genus/species
  write.table(allHosts, file=title, sep="\t", append = FALSE , row.names = FALSE, col.names = FALSE, qmethod = "double")
  
  #create one giant file
  write.table(allHosts, file="all.tsv", sep="\t", append = TRUE , row.names = FALSE, col.names = FALSE)
}

#insert into mysql database using load data all.tsv

#################################
#################################


## information below about the idigbio api and ridigbio
#https://github.com/cran/ridigbio

#returns all searchable fields
idig_meta_fields()

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

idig_meta_fields
