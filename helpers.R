init <- function() {
  # Auto Install Packages
  list.of.packages <- c("dplyr")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)

  ## Bring in the libs.
  library(dplyr)

  ## Download data if needed.
  dlData()
}

dlData <- function() {
  ## Download datasets if needed.
  if (!file.exists('./Source_Classification_Code.rds') ||
      !file.exists('./summarySCC_PM25.rds')) {
    if (!file.exists('nei.zip')) {
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(fileUrl, destfile="./nei.zip", method="curl")
    }
    unzip("./nei.zip", exdir = ".", overwrite = TRUE)
  }
}

# buildData <- function() {
#   if (!exists('poldata')) {
#     ## This first line will likely take a few seconds. Be patient!
#     NEI <- readRDS("summarySCC_PM25.rds")
#     SCC <- readRDS("Source_Classification_Code.rds")
#   }
# }


