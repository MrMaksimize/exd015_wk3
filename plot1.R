## Set WD to the location of file
setwd(dirname(parent.frame(2)$ofile))

source('helpers.R')

# Initialize, downloading data if needed.
init()

if (!exists('NEI') || !exists('SCC')) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
  SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))
}

pol_year <- group_by(NEI, year) %>%
  summarise(total_emissions = sum(Emissions))


with(pol_year, plot(
  lwd = 3,
  year,
  total_emissions/1000000,
  main = "Total Emissions By Year",
  type="b",
  col = "blue",
  ylab = "Total Emissions (in millions of tons)"
))




#dev.copy(png, file="./plot1.png")
#dev.off()
