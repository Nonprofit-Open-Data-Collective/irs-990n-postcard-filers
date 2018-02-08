


## BUILD THE DATASET




# create subdirectory for the data

getwd()

dir.create( "IRS Nonprofit Data" )

setwd( "./IRS Nonprofit Data" )



# download and unzip

file.url <- "https://apps.irs.gov/pub/epostcard/data-download-epostcard.zip"

download.file( url=file.url, "epostcard.zip" )

unzip( "epostcard.zip" )

file.remove( "epostcard.zip" )

dat.990n <- read.delim( file="data-download-epostcard.txt", 
            header = FALSE, 
            sep = "|", 
            quote = "",
            dec = ".", 
            fill = TRUE,  
            colClasses="character"
          )


# add header information - variable names

var.names <- c("EIN", "Tax.Year", "Organization.Name", "Gross.Receipts.Under.$25,000", 
"Terminated", "Tax.Period.Begin.Date", "Tax.Period.End.Date", 
"Website.URL", "Officer.Name", "Officer.Address.Line.1", "Officer.Address.Line.2", 
"Officer.Address.City", "Officer.Address.Province", "Officer.Address.State", 
"Officer.Address.Postal.Code", "Officer.Address.Country", "Organization.Address.Line.1", 
"Organization.Address.Line.2", "Organization.Address.City", "Organization.Address.Province", 
"Organization.Address.State", "Organization.Address.Postal.Code", 
"Organization.Address.Country", "Doing.Business.As.Name.1", "Doing.Business.As.Name.2", 
"Doing.Business.As.Name.3")

names( dat.990n ) <- var.names

rm( var.names )


# change Tax.Year from YYYY-MM to YYYY

dat.990n$FileYear <- substr( dat.990n$Tax.Year, 1, 4 )




## EXPORT THE DATASET



# AS R DATA SET

saveRDS( dat.990n, file="PostcardFilers.rds" )


# AS CSV

write.csv( dat.990n, "PostcardFilers.csv", row.names=F )


# IN STATA

install.packages( "haven" )
library( haven )
write_dta( dat.990n, "PostcardFilers.dta" )


# IN SPSS  - creates a text file and a script for reading it into SPSS

library( foreign )
write.foreign( df=dat.990n, datafile="PostcardFilers.txt", codefile="CodeToLoadDataInSPSS.txt", package="SPSS" )

# if package 'foreign' is not installed first try:  install.packages("foreign")
